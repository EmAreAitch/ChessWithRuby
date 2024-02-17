# frozen_string_literal: true

require_relative 'square'

class Row
  attr_reader :row

  def initialize(row:)
    raise ArgumentError, 'Row takes array of square objects only' unless row.is_a?(Array) && row.all?(Square)

    @row = row
  end

  def [](square_index)
    @row[square_index]
  end

  def push(square)
    raise ArgumentError, 'Object must be of Square type' unless square.is_a?(Square)

    @row.push(square)
  end

  def to_s
    @row.map(&:to_s).join
  end
end
