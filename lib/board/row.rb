# frozen_string_literal: true

require_relative 'square'
require_relative 'dimension'

# Represents rows in chess board
# Responsible for tracking pieces in that row of the chess board
class Row
  include Dimension

  def valid_directions
    %i[left right both].freeze
  end
end
