# frozen_string_literal: true

require_relative 'cell'

class Diagonal
  def initialize(diagonal:)
    raise ArgumentError, 'Diagonal takes array of cell objects only' unless diagonal.is_a?(Array) && diagonal.all?(Cell)

    @diagonal = diagonal
  end

  def [](cell_index)
    @diagonal[cell_index]
  end
end
