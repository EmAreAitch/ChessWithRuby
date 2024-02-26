# frozen_string_literal: true

require_relative 'piece_helper'

# Represents Bishop in Chess
# Responsible for dealing with game logic for bishop
class Bishop
  include PieceHelper

  def symbol
    '♝'
  end
end
