# frozen_string_literal: true

require_relative 'board/board'
require_relative 'piece/piece_controller'

chess_board = Board.new
piece_controller = PiecesController.new(board: chess_board)
puts chess_board
piece_controller.move_piece('e2', 'e4')
piece_controller.move_piece('e1', 'e2')
piece_controller.move_piece('e2', 'f3')
piece_controller.move_piece('f3', 'f4')
piece_controller.move_piece('f4', 'f5')
piece_controller.move_piece('f5', 'g6')
piece_controller.move_piece('g6', 'h7')
puts chess_board
