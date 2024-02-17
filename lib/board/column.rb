# frozen_string_literal: true

require_relative 'square'

class Column
  attr_reader :column

  def initialize(column:)
    raise ArgumentError, 'Column takes array of square objects only' unless column.is_a?(Array) && column.all?(Square)

    @column = column
  end

  def [](square_index)
    @column[square_index]
  end

  def push(square)
    raise ArgumentError, 'Object must of Square type' unless square.is_a?(Square)

    @column.push(square)
  end
end
