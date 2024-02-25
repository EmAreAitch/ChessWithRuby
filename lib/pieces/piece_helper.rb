# frozen_string_literal: true

# Helper module for pieces
module PieceHelper
  WHITE_FONT = "\e[38;2;255;255;255m"
  BLACK_FONT = "\e[38;2;0;0;0m"
  BOLD = "\e[1m"
  def white?
    @color.eql?(:white)
  end

  def color
    @color
  end

  def assign_square(square)
    @square = square
  end

  def black?
    @color.eql?(:black)
  end

  def opponent_color
    white? ? :black : :white
  end

  def inspect
    super.to_s
  end

  def move_to(end_square)
    raise 'Illegal Move' unless legal_moves.include? end_square

    @square.remove_piece
    end_square.put_piece self
    @square = end_square
    @moved_before = true unless moved_before?
  end

  def to_s
    symbol_color = white? ? WHITE_FONT : BLACK_FONT
    "#{BOLD}#{symbol_color}#{@symbol} "
  end
end
