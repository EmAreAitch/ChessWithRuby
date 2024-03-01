# frozen_string_literal: true

require_relative '../lib/board/board'

describe Board do # rubocop:disable Metrics/BlockLength
  subject(:board) { described_class.new }

  def get_expected_hash(l_index, r_index)
    {
      left: board.diagonals[:left][l_index],
      right: board.diagonals[:right][r_index]
    }
  end

  describe '#get_row' do
    context 'when the square index is less than 8' do
      it 'returns 0' do
        8.times do |i|
          expect(board.get_row(i)).to eq(board.rows[0])
        end
      end
    end

    context 'when the square index is less than 32 and greater than 24' do
      it 'returns 3' do
        24.upto 31 do |i|
          expect(board.get_row(i)).to eq(board.rows[3])
        end
      end
    end

    context 'when the square index is less than 0 or greater than 63' do
      it 'returns nil' do
        expect(board.get_row(-1)).to be_nil
        expect(board.get_row(-11)).to be_nil
        expect(board.get_row(64)).to be_nil
        expect(board.get_row(98)).to be_nil
      end
    end
  end
  describe '#get_column' do
    context 'when the square index is less than 8' do
      it 'returns value same as square index' do
        8.times do |i|
          expect(board.get_column(i)).to eq(board.columns[i])
        end
      end
    end

    context 'when the square index is less than 32 and greater than 24' do
      it 'returns square index - 24' do
        24.upto 31 do |i|
          expect(board.get_column(i)).to eq(board.columns[i - 24])
        end
      end
    end

    context 'when the square index is less than 0 or greater than 63' do
      it 'returns nil' do
        expect(board.get_column(-1)).to be_nil
        expect(board.get_column(-11)).to be_nil
        expect(board.get_column(64)).to be_nil
        expect(board.get_column(98)).to be_nil
      end
    end
  end

  describe '#get_diagonal' do
    context 'when the square index is less than 8' do
      it 'returns hash same as expected hash' do
        8.times do |i|
          expected_hash = get_expected_hash(i + 7, i)
          expect(board.get_diagonal(i)).to eq(expected_hash)
        end
      end
    end

    context 'when the square index is less than 32 and greater than 24' do
      it 'returns square index - 24' do
        24.upto 31 do |i|
          expected_hash = get_expected_hash(i - 20, i - 21)
          expect(board.get_diagonal(i)).to eq(expected_hash)
        end
      end
    end

    context 'when the square index is less than 0 or greater than 63' do
      it 'returns nil' do
        expect(board.get_diagonal(-1)).to be_nil
        expect(board.get_diagonal(-11)).to be_nil
        expect(board.get_diagonal(64)).to be_nil
        expect(board.get_diagonal(98)).to be_nil
      end
    end
  end

  describe '#to_s' do
    context 'when chessboard is empty' do
      it 'draws whole chessboard' do
        wht_bg = Square::WHITE_BACKGROUND
        blk_bg = Square::BLACK_BACKGROUND
        rst_bg = Square::RESET_BACKGROUND
        column_notation = "   #{[*'A'..'H'].join('   ')}"
        odd_row = ("#{wht_bg}    #{rst_bg + blk_bg}    #{rst_bg}" * 4).to_s
        even_row = ("#{blk_bg}    #{rst_bg + wht_bg}    #{rst_bg}" * 4).to_s
        rows = [*[odd_row, even_row] * 4].map.with_index { |row, index| "#{8 - index} #{row} #{8 - index}" }
        expected_result =  "#{column_notation}\n#{rows.join("\n")}\n#{column_notation}"
        expect(board.to_s).to eq(expected_result)
      end
    end
  end

  describe '#get_square_by_notation' do
    context 'when notation is e5' do
      it 'returns the 5th square from 4th row' do
        square = board.get_square_by_notation('e5')
        expect(board.rows[3][4]).to eq(square)
      end
    end
    context 'when notation is a1' do
      it 'returns the first square from last row' do
        square = board.get_square_by_notation('a1')
        expect(board.rows[7][0]).to eq(square)
      end
    end
    context 'when notation is h8' do
      it 'returns the last square from first row' do
        square = board.get_square_by_notation('h8')
        expect(board.rows[0][7]).to eq(square)
      end
    end
    context 'when notation is h9' do
      it 'returns nil' do
        square = board.get_square_by_notation('h9')
        expect(square).to be nil
      end
    end
  end
end
