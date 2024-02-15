# frozen_string_literal: true

require_relative 'cell'

class Diagonal
  def initialize(left:, right:)
    unless left.is_a?(Array) && right.is_a?(Array) && left.all?(Cell) && right.all?(Cell)
      raise ArgumentError,
            'Diagonal takes array of cell objects only'
    end

    @left = left
    @right = right
  end
end
