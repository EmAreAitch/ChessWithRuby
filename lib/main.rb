# frozen_string_literal: true

require_relative 'board/board'
require_relative 'pieces/piece_controller'

chess_board = Board.new
piece_controller = PiecesController.new(board: chess_board)
puts chess_board
piece_controller.move_piece('A2', 'A4')
piece_controller.move_piece('A4', 'A5')
piece_controller.move_piece('A5', 'A6')
piece_controller.move_piece('A6', 'B7')
puts
puts chess_board
