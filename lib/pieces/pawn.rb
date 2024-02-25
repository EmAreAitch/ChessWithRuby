# frozen_string_literal: true

require_relative 'piece_helper'

# Represents pawn in Chess
# Responsible for dealing with game logic for pawn
class Pawn
  include PieceHelper
  def initialize(color:)
    @color = color
    @symbol = '♟'
    @moved_before = false
  end

  def moved_before?
    @moved_before
  end

  def move_direction
    white? ? :above : :below
  end

  def capturable?(squares)
    return squares if squares[0]&.piece_color?(color: opponent_color)

    []
  end

  def legal_moves
    moves = moved_before? ? 1 : 2
    direction = move_direction
    squares_in_front = @square.get_squares_in_column(direction:)
    squares_at_left_diag = @square.get_squares_in_diagonal(diagonal: :left, direction:)
    squares_at_right_diag = @square.get_squares_in_diagonal(diagonal: :right, direction:)
    empty_squares_in_front = squares_in_front.take_while(&:empty?)
    empty_squares_in_front[0...moves] +
      capturable?(squares_at_left_diag[0..0]) +
      capturable?(squares_at_right_diag[0..0])
  end
end
