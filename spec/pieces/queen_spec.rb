# frozen_string_literal: true

require_relative '../../lib/piece/queen'
require_relative '../../lib/board/board'

describe Queen do # rubocop:disable Metrics/BlockLength
  subject(:white_queen) { Queen.new(color: :white) }
  subject(:black_queen) { Queen.new(color: :black) }
  subject(:board) { Board.new }
  describe '#move_to' do # rubocop:disable Metrics/BlockLength
    let(:start_square) { board.get_square_by_notation('e5') }
    def assert_move_success(start_square, end_square)
      expect(end_square.piece).to eq(white_queen)
      expect(start_square.empty?).to be true
      expect(white_queen.square).to eq(end_square)
    end
    context 'when trying to move legally from e5' do
      %w[e8 e1 a5 h5 h8 a1 b8 h2].each do |notation|
        it "moves to #{notation}" do
          start_square.put_piece white_queen
          end_square = board.get_square_by_notation(notation)
          white_queen.move_to end_square
          assert_move_success(start_square, end_square)
        end
      end
    end

    context 'when trying to capture piece from e5' do
      %w[e8 a1].each do |notation|
        it "captures piece at #{notation}" do
          start_square.put_piece white_queen
          end_square = board.get_square_by_notation(notation)
          end_square.put_piece black_queen
          white_queen.move_to end_square
          assert_move_success(start_square, end_square)
          expect(black_queen.on_board?).to be false
        end
      end
    end

    context 'when illegal move' do
      it 'fails to move through obstacle' do
        start_square.put_piece white_queen
        board.get_square_by_notation('e3').put_piece Queen.new(color: :black)
        end_square = board.get_square_by_notation('e1')
        expect { white_queen.move_to end_square }.to raise_error(RuntimeError)
      end
    end
  end
end
