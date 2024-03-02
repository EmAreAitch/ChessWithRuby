# frozen_string_literal: true

require_relative 'piece_helper'

# Represents king in Chess
# Responsible for dealing with game logic for king
class King
  include PieceHelper

  def symbol
    '♚'
  end

  def adjust_captures(squares)
    return squares if squares[-1]&.empty? || squares[-1]&.piece_color?(color: opponent_color)

    squares[...-1]
  end

  def legal_moves
    dimensions = []
    legal_moves_arr = []
    dimensions += @square.get_squares_in_diagonal(diagonal: :left, direction: :both, offset: 1)
    dimensions += @square.get_squares_in_diagonal(diagonal: :right, direction: :both, offset: 1)
    dimensions += @square.get_squares_in_column(direction: :both, offset: 1)
    dimensions += @square.get_squares_in_row(direction: :both, offset: 1)
    dimensions.each do |squares|
      legal_moves_arr += adjust_captures([squares])
    end
    legal_moves_arr
  end
end
