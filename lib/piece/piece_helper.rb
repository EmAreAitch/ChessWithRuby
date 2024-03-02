# frozen_string_literal: true

# Helper module for pieces
module PieceHelper
  WHITE_FONT = "\e[38;2;255;255;255m"
  BLACK_FONT = "\e[38;2;0;0;0m"
  BOLD = "\e[1m"

  attr_reader :square, :color

  def initialize(color:)
    @color = color
    @square = nil
    @moved_before = false
  end

  def moved_before?
    @moved_before
  end

  def white?
    @color.eql?(:white)
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

  def on_board?
    !@square.nil?
  end

  def move_to(end_square)
    unless legal_moves.include? end_square
      raise "Illegal Move - Total legal moves: #{legal_moves.length}, Legal moves: #{legal_moves}"
    end

    end_square.put_piece self
    @moved_before = true unless moved_before?
  end

  def to_s
    symbol_color = white? ? WHITE_FONT : BLACK_FONT
    "#{BOLD}#{symbol_color}#{symbol} "
  end
end