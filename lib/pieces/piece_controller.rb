# frozen_string_literal: true

require_relative 'king'
require_relative 'queen'
require_relative 'rook'
require_relative 'bishop'
require_relative 'knight'
require_relative 'pawn'

class PiecesController
  def initialize(board:)
    @board = board
    @white_player = initialize_player(:white)
    @black_player = initialize_player(:black)
    place_starting_pieces
  end

  def initialize_player(player_color)
    {
      king: King.new(color: player_color),
      queen: Queen.new(color: player_color),
      rook: Array.new(2) { Rook.new(color: player_color) },
      bishop: Array.new(2) { Bishop.new(color: player_color) },
      knight: Array.new(2) { Knight.new(color: player_color) },
      pawn: Array.new(8) { Pawn.new(color: player_color) }
    }
  end

  def place_starting_pieces
    place_player_edge_pieces(:white)
    place_player_pawns(:white)
    place_player_edge_pieces(:black)
    place_player_pawns(:black)
  end

  def place_player_pawns(player)
    if player.eql?(:white)
      pawns = @white_player[:pawn]
      @board.rows[-2].fill_row(pawns)
    else
      pawns = @black_player[:pawn]
      @board.rows[1].fill_row(pawns)
    end
  end

  def place_player_edge_pieces(player)
    player_hash = player.eql?(:white) ? @white_player : @black_player
    index = player.eql?(:white) ? -1 : 0
    player_hash => {king:, queen:, rook:, bishop:, knight:}
    player_edge_row = [rook[0], knight[0], bishop[0], queen, king, bishop[1], knight[1], rook[1]]
    @board.rows[index].fill_row(player_edge_row)
  end
end