# frozen_string_literal: true

require_relative 'piece_helper'

# Represents king in Chess
# Responsible for dealing with game logic for king
class King
  include PieceHelper

  def symbol
    '♚'
  end

  def legal_moves
    dimensions = []
    dimensions += @square.get_squares_in_diagonal(diagonal: :left, direction: :both, offset: 1)
    dimensions += @square.get_squares_in_diagonal(diagonal: :right, direction: :both, offset: 1)
    dimensions += @square.get_squares_in_column(direction: :both, offset: 1)
    dimensions += @square.get_squares_in_row(direction: :both, offset: 1)
    dimensions.compact.reduce(Set.new) do |set, squares|
      set | adjust_captures([squares])
    end
  end
end
