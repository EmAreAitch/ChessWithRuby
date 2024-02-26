# frozen_string_literal: true

require_relative 'square'

# Represents diagonals in chess board
# Responsible for tracking pieces in that diagonal of the chess board
class Diagonal
  attr_reader :diagonal

  VALID_DIRECTIONS = %i[above below both].freeze
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

  def get_squares(square, direction:)
    raise ArgumentError, ":#{direction} Invalid Direction" unless VALID_DIRECTIONS.include? direction

    square_index = @diagonal.index(square)
    if direction.eql?(:above)
      @diagonal[...square_index].reverse
    elsif direction.eql?(:below)
      @diagonal[square_index + 1..]
    else
      [@diagonal[...square_index].reverse, @diagonal[square_index + 1..]]
    end
  end

  def push(square)
    raise ArgumentError, 'Object must of Square type' unless square.is_a?(Square)

    @diagonal.push(square)
  end
end
