# frozen_string_literal: true

%w[king queen rook bishop knight pawn].each { |file| require_relative file }
require_relative '../player/player'
require_relative 'end_game_logic'
# Represents Pieces in Chess
# Responsible for dealing with game logic for chess moves
class PiecesController
  include EndGameLogic
  attr_reader :captured, :white_player, :black_player, :current_player

  def initialize(board:)
    @board = board
    @white_player = initialize_player(:white)
    @black_player = initialize_player(:black)
    @white_player.assign_opponent @black_player
    @black_player.assign_opponent @white_player
    @current_player = @white_player
    @captured = []
  end

  def legal_piece?(piece)
    return false unless piece.is_a?(PieceHelper) && piece.belongs_to?(@current_player)

    piece.legal_moves.any? { |square| !causes_check?(piece, square, @current_player) }
  end

  def initialize_player(player_color)
    Player.new(color: player_color, pieces:
    {
      king: King.new(color: player_color),
      queen: Queen.new(color: player_color),
      rooks: Array.new(2) { Rook.new(color: player_color) },
      bishops: Array.new(2) { Bishop.new(color: player_color) },
      knights: Array.new(2) { Knight.new(color: player_color) },
      pawns: Array.new(8) { Pawn.new(color: player_color) }
    })
  end

  def place_starting_pieces
    place_player_edge_pieces(@white_player)
    place_player_pawns(@white_player)
    place_player_edge_pieces(@black_player)
    place_player_pawns(@black_player)
  end

  def place_player_pawns(player)
    index = player.white? ? -2 : 1
    @board.rows[index].fill(player.pawns)
  end

  def place_player_edge_pieces(player)
    index = player.white? ? -1 : 0
    @board.rows[index].fill(player.back_row)
  end

  def move_piece(start_square_notation, end_square_notation)
    start_square = @board.get_square_by_notation(start_square_notation)
    end_square = @board.get_square_by_notation(end_square_notation)
    end_square_piece = end_square.piece
    piece = start_square.piece
    raise 'Square is empty' unless piece

    piece.move_to(end_square)
    @captured << end_square_piece if end_square_piece
  rescue RuntimeError => e
    puts e.message
  end

  def opponent_color(color)
    raise ArgumentError, 'Invalid Color, It must be in :white or :black' unless %i[white black].include?(color)

    color.eql?(:white) ? :black : :white
  end
end
