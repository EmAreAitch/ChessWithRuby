# frozen_string_literal: true

require_relative 'board/board'
require_relative 'pieces/piece_controller'

chess_board = Board.new
piece_controller = PiecesController.new(board: chess_board)
puts chess_board
piece_controller.move_piece('A2', 'A4')
piece_controller.move_piece('A1', 'A3')
piece_controller.move_piece('A3', 'H3')
piece_controller.move_piece('H3', 'H7')
puts
puts chess_board
