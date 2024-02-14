# frozen_string_literal: true

class Cell
  attr_reader :row, :column, :diagonal, :color

  def initialize(options:)
    @row = options[:row]
    @column = options[:column]
    @diagonal = options[:diagonal]
    @piece ||= options[:piece]
    @color = options[:color]
  end
end
