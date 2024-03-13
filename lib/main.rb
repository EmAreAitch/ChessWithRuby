# frozen_string_literal: true

require_relative 'board/board'
require_relative 'piece/piece_controller'

chess_board = Board.new
piece_controller = PiecesController.new(board: chess_board)
piece_controller.place_starting_pieces
puts chess_board
