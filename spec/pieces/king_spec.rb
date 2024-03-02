# frozen_string_literal: true

require_relative '../../lib/piece/king'
require_relative '../../lib/board/board'

describe King do # rubocop:disable Metrics/BlockLength
  subject(:white_king) { King.new(color: :white) }
  subject(:black_king) { King.new(color: :black) }
  subject(:board) { Board.new }
  describe '#move_to' do # rubocop:disable Metrics/BlockLength
    let(:start_square) { board.get_square_by_notation('e5') }
    def assert_move_success(start_square, end_square)
      expect(end_square.piece).to eq(white_king)
      expect(start_square.empty?).to be true
      expect(white_king.square).to eq(end_square)
    end
    context 'when trying to move legally from e5' do
      %w[d5 f5 e6 e4 f6 d4 d6 f4].each do |notation|
        it "moves to #{notation}" do
          start_square.put_piece white_king
          end_square = board.get_square_by_notation(notation)
          white_king.move_to end_square
          assert_move_success(start_square, end_square)
        end
      end
    end

    context 'when trying to capture piece from e5' do
      %w[d5 f6].each do |notation|
        it "captures piece at #{notation}" do
          start_square.put_piece white_king
          end_square = board.get_square_by_notation(notation)
          end_square.put_piece black_king
          white_king.move_to end_square
          assert_move_success(start_square, end_square)
          expect(black_king.on_board?).to be false
        end
      end
    end

    context 'when illegal move' do
      it 'fails to move on square with same color piece' do
        start_square.put_piece white_king
        board.get_square_by_notation('e4').put_piece King.new(color: :white)
        end_square = board.get_square_by_notation('e4')
        expect { white_king.move_to end_square }.to raise_error(RuntimeError)
      end

      it 'fails to move on squares that are not on the side' do
        %w[e8 e1 a5 h5 d3 f3 g4 g6].each do |notation|
          start_square.put_piece white_king
          end_square = board.get_square_by_notation(notation)
          expect { white_king.move_to end_square }.to raise_error(RuntimeError)
        end
      end
    end
  end
end
