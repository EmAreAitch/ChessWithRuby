# frozen_string_literal: true

require_relative 'piece_helper'

# Represents rook in Chess
# Responsible for dealing with game logic for rook
class Rook
  include PieceHelper

  def symbol
    '♜'
  end

  def adjust_captures(squares)
    return squares if squares[-1]&.empty? || squares[-1]&.piece_color?(color: opponent_color)

    squares[...-1]
  end

  def legal_moves
    dimensions = []
    legal_moves_arr = []
    dimensions += @square.get_squares_in_column(direction: :both)
    dimensions += @square.get_squares_in_row(direction: :both)
    dimensions.each do |squares|
      legal_moves_arr += adjust_captures(squares[..squares.index(&:piece?)])
    end
    legal_moves_arr
  end
end
