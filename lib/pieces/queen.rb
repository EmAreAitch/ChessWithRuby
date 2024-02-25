# frozen_string_literal: true

require_relative 'piece_helper'

# Represents queen in Chess
# Responsible for dealing with game logic for queen
class Queen
  include PieceHelper
  def initialize(color:)
    @color = color
    @symbol = '♛'
  end
end
