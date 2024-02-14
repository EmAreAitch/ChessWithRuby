# frozen_string_literal: true

require_relative 'cell'

class Column
  def initialize(column:)
    raise ArgumentError, 'Column takes array of cell objects only' unless column.is_a?(Array) && column.all?(Cell)

    @column = column
  end

  def [](cell_index)
    @column[cell_index]
  end
end
