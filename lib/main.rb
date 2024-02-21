# frozen_string_literal: true

require_relative 'board/board'
require_relative 'pieces/piece_controller'

chess_board = Board.new
piece_controller = PiecesController.new(board: chess_board)
puts chess_board
