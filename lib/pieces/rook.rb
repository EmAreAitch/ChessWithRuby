# frozen_string_literal: true

require_relative 'piece_helper'

# Represents rook in Chess
# Responsible for dealing with game logic for rook
class Rook
  include PieceHelper

  def symbol
    '♜'
  end

  def captures(squares)
    return squares if squares[-1]&.empty? || squares[-1]&.piece_color?(color: opponent_color)

    squares[...-1]
  end

  def legal_moves
    column_squares = @square.get_squares_in_column(direction: :both)
    row_squares = @square.get_squares_in_row(direction: :both)
    column_squares.map! { |squares| captures(squares[..squares.index(&:piece?)]) }
    row_squares.map! { |squares| captures(squares[..squares.index(&:piece?)]) }
    column_squares.flatten + row_squares.flatten
  end
end
