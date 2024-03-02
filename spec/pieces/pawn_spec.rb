# frozen_string_literal: true

require_relative '../../lib/piece/pawn'
require_relative '../../lib/board/board'

describe Pawn do # rubocop:disable Metrics/BlockLength
  subject(:white_pawn) { Pawn.new(color: :white) }
  subject(:black_pawn) { Pawn.new(color: :black) }
  subject(:board) { Board.new }

  describe '#move_to' do # rubocop:disable Metrics/BlockLength
    def assert_move_success(start_square, end_square)
      expect(end_square.piece).to eq(white_pawn)
      expect(start_square.empty?).to be true
      expect(white_pawn.square).to eq(end_square)
    end

    context 'when trying to move to empty square in front' do
      it 'moves to that square' do
        start_square = board.get_square_by_notation('a2')
        end_square = board.get_square_by_notation('a3')
        start_square.put_piece white_pawn
        white_pawn.move_to(end_square)
        assert_move_success(start_square, end_square)
      end
    end

    context 'when trying to move to two empty squares in front (initial position)' do
      it 'moves to that square' do
        start_square = board.get_square_by_notation('a2')
        end_square = board.get_square_by_notation('a4')
        start_square.put_piece white_pawn
        white_pawn.move_to(end_square)
        assert_move_success(start_square, end_square)
      end
    end
    context 'when trying to move to two empty squares in front (not initial position)' do
      it 'raises error' do
        start_square = board.get_square_by_notation('a2')
        end_square = board.get_square_by_notation('a3')
        start_square.put_piece white_pawn
        white_pawn.move_to(end_square)
        assert_move_success(start_square, end_square)
        end_square = board.get_square_by_notation('a5')
        expect { white_pawn.move_to(end_square) }.to raise_error(RuntimeError)
      end
    end
    context 'when trying to capture piece on diagonal' do
      it 'captures that piece' do
        start_square = board.get_square_by_notation('a2')
        end_square = board.get_square_by_notation('b3')
        start_square.put_piece white_pawn
        end_square.put_piece black_pawn
        white_pawn.move_to(end_square)
        assert_move_success(start_square, end_square)
        expect(black_pawn.square).to be_nil
      end
    end
    context 'when trying to make illegal move' do # rubocop:disable Metrics/BlockLength
      let(:start_square) { board.get_square_by_notation('a2') }
      it 'fails to move backward' do
        end_square_a = board.get_square_by_notation('a1')
        start_square.put_piece white_pawn
        expect { white_pawn.move_to(end_square_a) }.to raise_error(RuntimeError)
        end_square_a = board.get_square_by_notation('a3')
        start_square.put_piece black_pawn
        expect { black_pawn.move_to(end_square_a) }.to raise_error(RuntimeError)
      end

      it 'fails to move sideward' do
        end_square = board.get_square_by_notation('b2')
        start_square.put_piece white_pawn
        expect { white_pawn.move_to(end_square) }.to raise_error(RuntimeError)
      end

      it 'fails to move to empty diagonal' do
        end_square = board.get_square_by_notation('b3')
        start_square.put_piece white_pawn
        expect { white_pawn.move_to(end_square) }.to raise_error(RuntimeError)
      end

      it 'fails to move to square infront with piece' do
        end_square_a = board.get_square_by_notation('a3')
        end_square_b = board.get_square_by_notation('a3')
        start_square.put_piece white_pawn
        end_square_a.put_piece black_pawn
        expect { white_pawn.move_to(end_square_a) }.to raise_error(RuntimeError)
        expect { white_pawn.move_to(end_square_b) }.to raise_error(RuntimeError)
      end
    end
  end
end
