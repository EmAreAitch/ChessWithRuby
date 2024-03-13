# frozen_string_literal: true

require_relative 'piece_helper'

# Represents rook in Chess
# Responsible for dealing with game logic for rook
class Rook
  include PieceHelper

  def symbol
    '♜'
  end

  def legal_moves
    dimensions = []
    dimensions += @square.get_squares_in_column(direction: :both)
    dimensions += @square.get_squares_in_row(direction: :both)
    dimensions.reduce(Set.new) do |set, squares|
      set | adjust_captures(squares[..squares.index(&:piece?)])
    end
  end
end
