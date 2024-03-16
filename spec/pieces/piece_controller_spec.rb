# frozen_string_literal: true

require_relative '../../lib/piece/piece_controller'
require_relative '../../lib/board/board'

describe PiecesController do # rubocop:disable Metrics/BlockLength
  subject(:board) { Board.new }
  subject(:piece_controller) { PiecesController.new(board:) }
  let(:white_player) { piece_controller.white_player }
  let(:black_player) { piece_controller.black_player }
  describe '#in_check?' do
    context 'when king is in check by bishop' do
      it 'returns true' do
        board.get_square_by_notation('a1').put_piece white_player.bishops[0]
        board.get_square_by_notation('h8').put_piece black_player.king
        expect(piece_controller.in_check?(black_player)).to be true
      end
    end
    context 'when king is in check by knight' do
      it 'returns true' do
        board.get_square_by_notation('f7').put_piece white_player.knights[0]
        board.get_square_by_notation('h8').put_piece black_player.king
        expect(piece_controller.in_check?(black_player)).to be true
      end
    end

    context 'when king is not in check by any piece' do
      it 'returns false' do
        board.get_square_by_notation('g7').put_piece white_player.knights[0]
        board.get_square_by_notation('e8').put_piece white_player.bishops[0]
        board.get_square_by_notation('a1').put_piece white_player.rooks[0]
        board.get_square_by_notation('h8').put_piece black_player.king
        expect(piece_controller.in_check?(black_player)).to be false
      end
    end
  end
  describe '#checkmate?' do # rubocop:disable Metrics/BlockLength
    context 'when king got checkmate by rooks' do
      it 'returns true' do
        board.get_square_by_notation('a8').put_piece white_player.rooks[0]
        board.get_square_by_notation('a7').put_piece white_player.rooks[1]
        board.get_square_by_notation('h8').put_piece black_player.king
        expect(piece_controller.checkmate?(black_player)).to be true
      end
    end
    context 'when king can move from check' do
      it 'returns false' do
        board.get_square_by_notation('a8').put_piece white_player.rooks[0]
        board.get_square_by_notation('h8').put_piece black_player.king
        expect(piece_controller.checkmate?(black_player)).to be false
      end
    end
    context 'when a check can be blocked' do
      it 'returns false' do
        board.get_square_by_notation('d8').put_piece black_player.rooks[0]
        board.get_square_by_notation('d7').put_piece black_player.rooks[1]
        board.get_square_by_notation('c8').put_piece black_player.king
        board.get_square_by_notation('a6').put_piece white_player.bishops[0]
        board.get_square_by_notation('f4').put_piece white_player.bishops[1]
        expect(piece_controller.checkmate?(black_player)).to be false
      end
    end
    context 'when a illegal move can block check' do
      it 'returns true' do
        board.get_square_by_notation('d8').put_piece black_player.rooks[0]
        board.get_square_by_notation('d7').put_piece black_player.rooks[1]
        board.get_square_by_notation('c8').put_piece black_player.king
        board.get_square_by_notation('a6').put_piece white_player.bishops[0]
        board.get_square_by_notation('f4').put_piece white_player.bishops[1]
        board.get_square_by_notation('f5').put_piece white_player.queen
        expect(piece_controller.checkmate?(black_player)).to be true
      end
    end
    context 'when king is in check by capturable rook' do
      it 'returns false' do
        board.get_square_by_notation('f8').put_piece black_player.rooks[0]
        board.get_square_by_notation('g7').put_piece black_player.rooks[1]
        board.get_square_by_notation('g8').put_piece black_player.king
        board.get_square_by_notation('h8').put_piece white_player.rooks[1]
        expect(piece_controller.checkmate?(black_player)).to be false
      end
    end
    context 'when king is in check by rook that is capturable by other piece' do
      it 'returns false' do
        board.get_square_by_notation('e8').put_piece black_player.rooks[0]
        board.get_square_by_notation('h2').put_piece black_player.rooks[1]
        board.get_square_by_notation('f8').put_piece black_player.king
        board.get_square_by_notation('h8').put_piece white_player.rooks[1]
        expect(piece_controller.checkmate?(black_player)).to be false
      end
    end
    context 'when king is in check by blockable rook' do
      it 'returns false' do
        board.get_square_by_notation('a8').put_piece white_player.rooks[0]
        board.get_square_by_notation('a7').put_piece white_player.rooks[1]
        board.get_square_by_notation('h8').put_piece black_player.king
        board.get_square_by_notation('d1').put_piece black_player.rooks[0]
        expect(piece_controller.checkmate?(black_player)).to be false
      end
    end
  end

  describe '#stalemate?' do
    context 'when king is at a3 and is blocked by pawn at a4' do
      it 'returns true' do
        board.get_square_by_notation('a4').put_piece black_player.pawns[0]
        board.get_square_by_notation('a3').put_piece black_player.king
        board.get_square_by_notation('b8').put_piece white_player.rooks[0]
        board.get_square_by_notation('b1').put_piece white_player.king
        board.get_square_by_notation('d4').put_piece white_player.rooks[1]
        expect(piece_controller.stalemate?(black_player)).to be true
      end
    end
    context 'when king is at a3 and is not blocked by pawn at a5' do
      it 'returns false' do
        board.get_square_by_notation('a5').put_piece black_player.pawns[0]
        board.get_square_by_notation('a3').put_piece black_player.king
        board.get_square_by_notation('b8').put_piece white_player.rooks[0]
        board.get_square_by_notation('b1').put_piece white_player.king
        board.get_square_by_notation('d4').put_piece white_player.rooks[1]
        expect(piece_controller.stalemate?(black_player)).to be false
      end
    end
  end
end
