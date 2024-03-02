# frozen_string_literal: true

require_relative 'piece_helper'

# Represents knight in Chess
# Responsible for dealing with game logic for knight
class Knight
  include PieceHelper

  def symbol
    '♞'
  end

  def adjust_captures(squares)
    return squares if squares[-1]&.empty? || squares[-1]&.piece_color?(color: opponent_color)

    squares[...-1]
  end

  def legal_moves
    legal_moves_arr = []
    v_hops = @square.get_squares_in_column(direction: :both, offset: 2)
    h_hops = @square.get_squares_in_row(direction: :both, offset: 2)
    turns = v_hops.reduce([]) { |l, square| l + [*square&.get_squares_in_row(direction: :both, offset: 1)] }
    turns += h_hops.reduce([]) { |l, square| l + [*square&.get_squares_in_column(direction: :both, offset: 1)] }
    turns.compact.each do |square|
      legal_moves_arr += adjust_captures([square])
    end
    legal_moves_arr
  end
end
