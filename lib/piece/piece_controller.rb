# frozen_string_literal: true

%w[king queen rook bishop knight pawn].each { |file| require_relative file }
require_relative '../player/player'
# Represents Pieces in Chess
# Responsible for dealing with game logic for chess moves
class PiecesController
  attr_reader :captured, :white_player, :black_player

  def initialize(board:)
    @board = board
    @white_player = initialize_player(:white)
    @black_player = initialize_player(:black)
    @white_player.assign_opponent @black_player
    @black_player.assign_opponent @white_player
    @captured = []
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

  def pieces_threatening_king(player)
    opponent = player.opponent
    king_square = player.king.square
    player_pieces = opponent.pieces_on_board
    player_pieces.filter { |piece| piece.legal_moves.include? king_square }
  end

  def in_check?(player, opponent_legal_moves = player.opponent.player_legal_moves)
    opponent_legal_moves.include?(player.king.square)
  end

  def causes_check?(piece, end_square, player)
    return false unless piece.color == player.color

    temp_piece = end_square.remove_piece
    temp_square = piece.square
    end_square.put_piece piece
    check = in_check?(player)
    temp_square.put_piece piece
    end_square.put_piece temp_piece if temp_piece
    check
  end

  def checkmate?(opponent_legal_moves, player)
    !(can_move_from_check?(opponent_legal_moves, player) || can_block_check?(player))
  end

  def can_move_from_check?(opponent_legal_moves, player)
    player.king.legal_moves.each do |square|
      return true if square.empty? && !in_check?(player, opponent_legal_moves)
      next unless square.piece?

      temp_piece = square.remove_piece
      opp_temp_legal_moves = player.opponent.player_legal_moves
      square.put_piece(temp_piece)
      return true unless in_check?(player, opp_temp_legal_moves)
    end
    false
  end

  def stalemate?(player)
    return false if in_check? player

    player.pieces_on_board.all? do |piece|
      piece.legal_moves.all? do |move|
        causes_check?(piece, move, player)
      end
    end
  end

  def can_block_check?(player)
    pieces = pieces_threatening_king(player)
    return false unless pieces.length == 1

    player_pieces = player.pieces_on_board
    squares_in_between = player.king.square.get_squares_in_between(pieces[0].square)
    player_pieces.any? do |piece|
      next if piece.is_a? King

      common_squares = piece.legal_moves & squares_in_between
      common_squares.any? { |square| !causes_check?(piece, square, player) }
    end
  end
end
