# frozen_string_literal: true

# Module for end game logic methods
module EndGameLogic
  def pieces_threatening_king(player)
    opponent = player.opponent
    king_square = player.king.square
    player_pieces = opponent.pieces_on_board
    player_pieces.filter { |piece| piece.legal_moves.include? king_square }
  end

  def in_check?(player)
    king = player.king
    dimensional_threat = %i[column row right_diagonal left_diagonal].any? { |dimension| king.threats?(dimension:) }
    return true if dimensional_threat

    opponent_knights = player.opponent.knights.filter(&:on_board?)
    opponent_knights.any? { |knight| knight.legal_moves.include?(king.square) }
  end

  def causes_check?(piece, end_square, player)
    temp_square = piece.square
    temp_piece = end_square.remove_piece
    end_square.put_piece piece
    check = in_check?(player)
    temp_square.put_piece piece
    end_square.put_piece temp_piece if temp_piece
    check
  end

  def checkmate?(player)
    !can_move_from_check?(player) && !can_block_check?(player)
  end

  def stalemate?(player)
    return false if in_check? player

    player.pieces_on_board.all? do |piece|
      piece.legal_moves.all? do |move|
        causes_check?(piece, move, player)
      end
    end
  end

  def can_move_from_check?(player)
    player.king.legal_moves.any? do |square|
      !causes_check?(player.king, square, player)
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
