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

  def build_square(index)
    color = %i[white black]
    color_index = (index / 8).even? ? index % 2 : (index + 1) % 2
    options = {
      piece: nil,
      color: color[color_index],
      **get_square_position(index)
    }
    Square.new(options: options)
  end

  def get_square_position(index)
    {
      row: get_row(index),
      column: get_column(index),
      diagonal: get_diagonal(index)
    }
  end

  def get_row(index)
    @rows[index / 8]
  end

  def get_column(index)
    @columns[index % 8]
  end

  def get_diagonal(index)
    row_pos = index / 8
    col_pos = index % 8
    left_diag_pos = 7 - (row_pos - col_pos)
    right_diag_pos = 7 - (7 - row_pos - col_pos)
    {
      left: @diagonals[:left][left_diag_pos],
      right: @diagonals[:right][right_diag_pos]
    }
  end

  def to_s
    rows.map(&:to_s).join("\n")
  end
end
