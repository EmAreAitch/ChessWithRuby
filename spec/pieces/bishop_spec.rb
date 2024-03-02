# frozen_string_literal: true

require_relative '../../lib/piece/bishop'
require_relative '../../lib/board/board'

describe Bishop do # rubocop:disable Metrics/BlockLength
  subject(:white_bishop) { Bishop.new(color: :white) }
  subject(:black_bishop) { Bishop.new(color: :black) }
  subject(:board) { Board.new }
  describe '#move_to' do # rubocop:disable Metrics/BlockLength
    let(:start_square) { board.get_square_by_notation('e5') }
    def assert_move_success(start_square, end_square)
      expect(end_square.piece).to eq(white_bishop)
      expect(start_square.empty?).to be true
      expect(white_bishop.square).to eq(end_square)
    end
    context 'when trying to go to corner square direct from e5' do
      %w[f6 d4 d6 f4].each do |notation|
        it "fails to move to #{notation}" do
          start_square.put_piece white_bishop
          end_square = board.get_square_by_notation(notation)
          white_bishop.move_to end_square
          assert_move_success(start_square, end_square)
        end
      end
    end
    context 'when trying to capture piece on right diagonal' do
      it 'captures in both direction' do
        start_square.put_piece white_bishop
        %w[h8 a1].each do |i|
          end_square = board.get_square_by_notation(i)
          end_square.put_piece black_bishop
          white_bishop.move_to end_square
          assert_move_success(start_square, end_square)
          expect(black_bishop.on_board?).to be false
        end
      end
    end
    context 'when trying to capture piece on left diagonal' do
      it 'captures in both direction' do
        start_square.put_piece white_bishop
        %w[b8 h2].each do |i|
          end_square = board.get_square_by_notation(i)
          end_square.put_piece black_bishop
          white_bishop.move_to end_square
          assert_move_success(start_square, end_square)
          expect(black_bishop.on_board?).to be false
        end
      end
    end
    context 'when the move is illegal' do
      it 'fails to move through obstacle' do
        start_square.put_piece white_bishop
        board.get_square_by_notation('c3').put_piece black_bishop
        end_square = board.get_square_by_notation('a1')
        expect { white_bishop.move_to(end_square) }.to raise_error(RuntimeError)
      end
      it 'fails to move on column' do
        start_square.put_piece white_bishop
        end_square = board.get_square_by_notation('e1')
        expect { white_bishop.move_to(end_square) }.to raise_error(RuntimeError)
      end
      it 'fails to move on row' do
        start_square.put_piece white_bishop
        end_square = board.get_square_by_notation('h5')
        expect { white_bishop.move_to(end_square) }.to raise_error(RuntimeError)
      end
    end
  end
end
