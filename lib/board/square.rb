# frozen_string_literal: true

class Square
  attr_reader :row, :column, :diagonal, :color, :piece

  WHITE_BACKGROUND = "\e[48;2;230;200;160m"
  BLACK_BACKGROUND = "\e[48;2;181;136;99m"
  RESET_BACKGROUND = "\e[0m"
  def initialize(options:)
    @row = options[:row]
    @column = options[:column]
    @diagonal = options[:diagonal]
    @piece = options[:piece]
    @color = options[:color]
  end

  def put_piece(piece)
    @piece = piece
  end

  def inspect
    "#<#{self.class}:0x#{(object_id << 1).to_s(16)} @piece=#{@piece}, @color=#{@color}>"
  end

  def to_s
    piece_icon = @piece || '  '
    return "#{WHITE_BACKGROUND} #{piece_icon} #{RESET_BACKGROUND}" if color == :white

    "#{BLACK_BACKGROUND} #{piece_icon} #{RESET_BACKGROUND}"
  end
end
