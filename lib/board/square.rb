# frozen_string_literal: true

# Represents individual squares in chess board
# Responsible for tracking piece in that square of the chess board
class Square
  attr_reader :row, :column, :diagonal, :color, :piece

  VALID_DIAGONAL = %i[left right].freeze
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
    @piece&.assign_square(nil)
    piece.square&.remove_piece
    @piece = piece
    @piece.assign_square(self)
  end

  def inspect
    "#<#{self.class}:0x#{(object_id << 1).to_s(16)} @piece=#{@piece.inspect}, @color=#{@color}>"
  end

  def piece?
    !@piece.nil?
  end

  def empty?
    !piece?
  end

  def piece_color?(color:)
    @piece&.color.eql?(color)
  end

  def remove_piece
    return nil unless piece?

    @piece&.assign_square(nil)
    temp_piece = @piece
    @piece = nil
    temp_piece
  end

  def get_squares_in_column(direction:, offset: nil)
    return @column.get_square_by_offset(self, offset, direction:) if offset

    @column.get_squares(self, direction:)
  end

  def get_squares_in_row(direction:, offset: nil)
    return @row.get_square_by_offset(self, offset, direction:) if offset

    @row.get_squares(self, direction:)
  end

  def get_squares_in_diagonal(diagonal:, direction:, offset: nil)
    raise ArgumentError, ":#{diagonal} Invalid Diagonal" unless VALID_DIAGONAL.include? diagonal
    return @diagonal[diagonal].get_square_by_offset(self, offset, direction:) if offset

    @diagonal[diagonal].get_squares(self, direction:)
  end

  def to_s
    piece_icon = @piece || '  '
    return "#{WHITE_BACKGROUND} #{piece_icon} #{RESET_BACKGROUND}" if color == :white

    "#{BLACK_BACKGROUND} #{piece_icon} #{RESET_BACKGROUND}"
  end
end
