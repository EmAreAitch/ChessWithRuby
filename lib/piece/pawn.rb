# frozen_string_literal: true

require_relative 'piece_helper'

# Represents pawn in Chess
# Responsible for dealing with game logic for pawn
class Pawn
  include PieceHelper
  def symbol
    '♟'
  end

  def move_direction
    white? ? :above : :below
  end

  def distance
    moved_before? ? 1 : 2
  end

  def legal_moves
    direction = move_direction
    front_squares = Set.new
    front_squares |= @square.get_squares_in_column(direction:)[...distance].take_while(&:empty?)
    diagonals = [@square.get_squares_in_diagonal(diagonal: :left, direction:, offset: 1),
                 @square.get_squares_in_diagonal(diagonal: :right, direction:, offset: 1)]
    front_squares | diagonals.compact.filter { |square| square.piece&.color.eql? opponent_color }
  end
end
