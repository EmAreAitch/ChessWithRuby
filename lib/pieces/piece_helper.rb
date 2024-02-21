# frozen_string_literal: true

module PieceHelper
  WHITE_FONT = "\e[38;2;255;255;255m"
  BLACK_FONT = "\e[38;2;0;0;0m"
  BOLD = "\e[1m"
  def white?
    @color.eql?(:white)
  end

  def black?
    @color.eql?(:black)
  end

  def to_s
    symbol_color = white? ? WHITE_FONT : BLACK_FONT
    "#{BOLD}#{symbol_color}#{@symbol} "
  end
end
