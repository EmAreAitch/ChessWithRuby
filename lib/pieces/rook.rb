# frozen_string_literal: true

require_relative 'piece_helper'

# Represents rook in Chess
# Responsible for dealing with game logic for rook
class Rook
  include PieceHelper
  def initialize(color:)
    @color = color
    @symbol = '♜'
  end
end
