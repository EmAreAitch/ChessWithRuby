# frozen_string_literal: true

require_relative 'piece_helper'

# Represents king in Chess
# Responsible for dealing with game logic for king
class King
  include PieceHelper

  def symbol
    '♚'
  end
end
