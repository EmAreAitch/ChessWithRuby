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

  def adjust_captures(squares)
    return squares if squares[-1]&.piece_color?(color: opponent_color)

    squares[...-1]
  end

  def legal_moves
    moves = moved_before? ? 1 : 2
    direction = move_direction
    squares_in_front = @square.get_squares_in_column(direction:)[0..1]
    squares_at_left_diag = @square.get_squares_in_diagonal(diagonal: :left, direction:)[0..0]
    squares_at_right_diag = @square.get_squares_in_diagonal(diagonal: :right, direction:)[0..0]
    empty_squares_in_front = squares_in_front.take_while(&:empty?)
    empty_squares_in_front[0...moves] +
      adjust_captures(squares_at_left_diag) +
      adjust_captures(squares_at_right_diag)
  end
end
