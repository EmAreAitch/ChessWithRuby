# frozen_string_literal: true

require_relative 'square'

class Diagonal
  attr_reader :diagonal

  def initialize(diagonal:)
    unless diagonal.is_a?(Array) && diagonal.all?(Square)
      raise ArgumentError,
            'Diagonal takes array of square objects only'
    end

    @diagonal = diagonal
  end

  def [](square_index)
    @diagonal[square_index]
  end

  def push(square)
    raise ArgumentError, 'Object must of Square type' unless square.is_a?(Square)

    @diagonal.push(square)
  end
end
