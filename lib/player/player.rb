# frozen_string_literal: true

# Class to represent individual player in game and all its properties
class Player
  attr_reader :color, :opponent, :pieces, :pieces_list

  def initialize(color:, pieces:)
    @color = color
    @pieces = pieces
    @pieces_list = pieces.values.flatten(1)
    @opponent = nil
  end

  def assign_opponent(opponent)
    @opponent = opponent
  end

  def white?
    @color.eql?(:white)
  end

  def black?
    @color.eql?(:black)
  end

  def pieces_on_board
    @pieces_list.filter(&:on_board?)
  end

  def player_legal_moves
    pieces_on_board.reduce(Set.new) do |set, piece|
      set | piece.legal_moves
    end
  end

  def king
    @pieces[:king]
  end

  def queen
    @pieces[:queen]
  end

  def pawns
    @pieces[:pawns]
  end

  def rooks
    @pieces[:rooks]
  end

  def bishops
    @pieces[:bishops]
  end

  def knights
    @pieces[:knights]
  end

  def back_row
    [rooks[0], knights[0], bishops[0], queen, king, bishops[1], knights[1], rooks[1]]
  end
end
