# frozen_string_literal: true

require_relative 'piece_helper'

# Represents knight in Chess
# Responsible for dealing with game logic for knight
class Knight
  include PieceHelper
  def initialize(color:)
    @color = color
    @symbol = '♞'
  end
end
