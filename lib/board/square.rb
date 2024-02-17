# frozen_string_literal: true

class Square
  attr_reader :row, :column, :diagonal, :color

  WHITE_BACKGROUND = "\e[48;2;230;200;160m"
  BLACK_BACKGROUND = "\e[48;2;181;136;99m"
  RESET_BACKGROUND = "\e[0m"
  def initialize(options:)
    @row = options[:row]
    @column = options[:column]
    @diagonal = options[:diagonal]
    @piece ||= options[:piece]
    @color = options[:color]
  end

  def to_s
    return "#{WHITE_BACKGROUND}   #{RESET_BACKGROUND}" if color == :white

    "#{BLACK_BACKGROUND}   #{RESET_BACKGROUND}"
  end
end
