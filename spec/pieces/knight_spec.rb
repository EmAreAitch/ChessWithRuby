# frozen_string_literal: true

require_relative '../../lib/piece/knight'
require_relative '../../lib/board/board'

describe Knight do # rubocop:disable Metrics/BlockLength
  subject(:white_knight) { Knight.new(color: :white) }
  subject(:black_knight) { Knight.new(color: :black) }
  subject(:board) { Board.new }
  describe '#move_to' do # rubocop:disable Metrics/BlockLength
    let(:start_square) { board.get_square_by_notation('e5') }
    def assert_move_success(start_square, end_square)
      expect(end_square.piece).to eq(white_knight)
      expect(start_square.empty?).to be true
      expect(white_knight.square).to eq(end_square)
    end
    context 'when trying to move legally from e5' do
      %w[f7 d7 c6 c4 d3 f3 g4 g6].each do |notation|
        it "moves to #{notation}" do
          start_square.put_piece white_knight
          end_square = board.get_square_by_notation(notation)
          white_knight.move_to end_square
          assert_move_success(start_square, end_square)
        end
      end
    end

    context 'when trying to capture piece on f7 from e5' do
      it 'captures piece at f7' do
        start_square.put_piece white_knight
        end_square = board.get_square_by_notation('f7')
        end_square.put_piece black_knight
        white_knight.move_to end_square
        assert_move_success(start_square, end_square)
        expect(black_knight.on_board?).to be false
      end
    end

    context 'when trying to move vertically and horizontally from e5' do
      %w[e8 e1 a5 h5].each do |notation|
        it "fails to move to #{notation}" do
          start_square.put_piece white_knight
          end_square = board.get_square_by_notation(notation)
          expect { white_knight.move_to end_square }.to raise_error(RuntimeError)
        end
      end
    end
    context 'when trying to move on diagonal from e5' do
      %w[h8 a1 b8 h2].each do |notation|
        it "fails to move to #{notation}" do
          start_square.put_piece white_knight
          end_square = board.get_square_by_notation(notation)
          expect { white_knight.move_to end_square }.to raise_error(RuntimeError)
        end
      end
    end
  end
end
