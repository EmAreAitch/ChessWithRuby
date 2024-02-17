# frozen_string_literal: true

require_relative 'cell'

class Row
  attr_reader :row

  def initialize(row:)
    raise ArgumentError, 'Row takes array of cell objects only' unless row.is_a?(Array) && row.all?(Cell)

    @row = row
  end

  def [](cell_index)
    @row[cell_index]
  end

  def push(cell)
    raise ArgumentError, 'Object must be of Cell type' unless cell.is_a?(Cell)

    @row.push(cell)
  end

  def to_s
    @row.map(&:to_s).join
  end
end
