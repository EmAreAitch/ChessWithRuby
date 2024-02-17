# frozen_string_literal: true

require_relative 'cell'

class Diagonal
  attr_reader :diagonal

  def initialize(diagonal:)
    raise ArgumentError, 'Diagonal takes array of cell objects only' unless diagonal.is_a?(Array) && diagonal.all?(Cell)

    @diagonal = diagonal
  end

  def [](cell_index)
    @diagonal[cell_index]
  end

  def push(cell)
    raise ArgumentError, 'Object must of Cell type' unless cell.is_a?(Cell)

    @diagonal.push(cell)
  end
end
