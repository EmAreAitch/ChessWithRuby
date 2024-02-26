# frozen_string_literal: true

require_relative 'square'
require_relative 'row'
require_relative 'column'
require_relative 'diagonal'

class Board
  attr_accessor :rows, :columns, :diagonals

  def initialize
    build_board
    assign_squares
  end

  def build_board
    @rows = Array.new(8) { Row.new(row: []) }
    @columns = Array.new(8) { Column.new(column: []) }
    @diagonals = {
      left: Array.new(15) { Diagonal.new(diagonal: []) },
      right: Array.new(15) { Diagonal.new(diagonal: []) }
    }
  end

  def assign_squares
    64.times do |i|
      square = build_square(i)
      square.row.push square
      square.column.push square
      square.diagonal[:left].push square
      square.diagonal[:right].push square
    end
  end

  def build_square(square_index)
    color = %i[white black]
    color_index = (square_index / 8).even? ? square_index % 2 : (square_index + 1) % 2
    options = {
      piece: nil,
      color: color[color_index],
      **get_square_position(square_index)
    }
    Square.new(options:)
  end

  def get_square_position(square_index)
    {
      row: get_row(square_index),
      column: get_column(square_index),
      diagonal: get_diagonal(square_index)
    }
  end

  def get_row(square_index)
    return nil unless square_index.between?(0, 63)

    @rows[square_index / 8]
  end

  def get_column(square_index)
    return nil unless square_index.between?(0, 63)

    @columns[square_index % 8]
  end

  def get_diagonal(square_index)
    return nil unless square_index.between?(0, 63)

    row_pos = square_index / 8
    col_pos = square_index % 8
    left_diag_pos = 7 - (row_pos - col_pos)
    right_diag_pos = row_pos + col_pos
    {
      left: @diagonals[:left][left_diag_pos],
      right: @diagonals[:right][right_diag_pos]
    }
  end

  def get_square_by_notation(notation)
    notation = notation.upcase
    column = notation[0].ord - 65
    row = notation[1].to_i
    @rows[-row][column]
  end

  def to_s
    column_notation = "   #{[*'A'..'H'].join('   ')}"
    board_string = rows.map.with_index { |row, index| "#{8 - index} #{row} #{8 - index}" }.join("\n")
    "#{column_notation}\n#{board_string}\n#{column_notation}"
  end

  def inspect
    "#<#{self.class}:0x#{(object_id << 1).to_s(16)} @rows=#{@rows}>"
  end
end
