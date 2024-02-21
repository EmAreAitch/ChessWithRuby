# frozen_string_literal: true

require_relative 'piece_helper'
class Rook
  include PieceHelper
  def initialize(color:)
    @color = color
    @symbol = '♜'
  end
end
