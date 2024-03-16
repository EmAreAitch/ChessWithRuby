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

  def threats?(dimension:)
    threats = square.get_nearest_occupied_square(dimension:, direction: :both).compact.map(&:piece)
    threats.filter! { |piece| piece.color == opponent_color }
    threats.reject! { |piece| (piece.is_a?(Pawn) or piece.is_a?(King)) and !next_to_each_other?(piece) }
    case dimension
    when :column, :row
      straight_attack?(threats)
    when :left_diagonal, :right_diagonal
      diagonal_attack?(threats)
    end
  end

  private

  def next_to_each_other?(piece)
    piece.square.get_squares_in_between(@square).length == 1
  end

  def straight_attack?(threats)
    threats.any? { |threat| threat.is_a?(Rook) || threat.is_a?(Queen) || threat.is_a?(King) }
  end

  def diagonal_attack?(threats)
    threats.any? { |threat| threat.is_a?(Bishop) || threat.is_a?(Queen) || threat.is_a?(Pawn) || threat.is_a?(King) }
  end
end
