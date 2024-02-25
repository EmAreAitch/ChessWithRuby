# frozen_string_literal: true

require_relative 'square'

# Represents columns in chess board
# Responsible for tracking pieces in that column of the chess board
class Column
  attr_reader :column

  VALID_DIRECTIONS = %i[above below].freeze
  def initialize(column:)
    raise ArgumentError, 'Column takes array of square objects only' unless column.is_a?(Array) && column.all?(Square)

    @column = column
  end

  def [](square_index)
    @column[square_index]
  end

  def get_squares(square, direction:)
    raise ArgumentError, ":#{direction} Invalid Direction" unless Column::VALID_DIRECTIONS.include? direction

    square_index = @column.index(square)
    if direction.eql?(:above)
      @column[...square_index].reverse
    else
      @column[square_index + 1..]
    end
  end

  def push(square)
    raise ArgumentError, 'Object must of Square type' unless square.is_a?(Square)

    @column.push(square)
  end
end
