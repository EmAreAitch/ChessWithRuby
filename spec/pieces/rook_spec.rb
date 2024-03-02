# frozen_string_literal: true

require_relative '../../lib/piece/rook'
require_relative '../../lib/board/board'

describe Rook do # rubocop:disable Metrics/BlockLength
  subject(:white_rook) { Rook.new(color: :white) }
  subject(:black_rook) { Rook.new(color: :black) }
  subject(:board) { Board.new }
  describe '#move_to' do # rubocop:disable Metrics/BlockLength
    let(:start_square) { board.get_square_by_notation('e5') }
    def assert_move_success(start_square, end_square)
      expect(end_square.piece).to eq(white_rook)
      expect(start_square.empty?).to be true
      expect(white_rook.square).to eq(end_square)
    end
    context 'when trying to move vertically and horizontally from e5' do
      %w[e8 e1 a5 h5].each do |notation|
        it "moves to #{notation}" do
          start_square.put_piece white_rook
          end_square = board.get_square_by_notation(notation)
          white_rook.move_to end_square
          assert_move_success(start_square, end_square)
        end
      end
    end
    context 'when trying to capture piece sideways' do
      it 'captures in both direction' do
        start_square.put_piece white_rook
        %w[h5 a5].each do |i|
          end_square = board.get_square_by_notation(i)
          end_square.put_piece black_rook
          white_rook.move_to end_square
          assert_move_success(start_square, end_square)
          expect(black_rook.on_board?).to be false
        end
      end
    end
    context 'when trying to capture piece vertically' do
      it 'captures in both direction' do
        start_square.put_piece white_rook
        %w[e8 e1].each do |i|
          end_square = board.get_square_by_notation(i)
          end_square.put_piece black_rook
          white_rook.move_to end_square
          assert_move_success(start_square, end_square)
          expect(black_rook.on_board?).to be false
        end
      end
    end
    context 'when the move is illegal' do
      it 'fails to move through obstacle' do
        start_square.put_piece white_rook
        board.get_square_by_notation('e3').put_piece black_rook
        end_square = board.get_square_by_notation('e1')
        expect { white_rook.move_to(end_square) }.to raise_error(RuntimeError)
      end
      it 'fails to move on diagonal' do
        start_square.put_piece white_rook
        end_square = board.get_square_by_notation('a2')
        expect { white_rook.move_to(end_square) }.to raise_error(RuntimeError)
      end
    end
  end
end
