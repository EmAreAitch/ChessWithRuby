require_relative 'cell'

class Row
	def initialize(row:)
		raise ArgumentError, "Row takes array of cell objects only" unless row.is_a?(Array) and row.all?(Cell)
		@row = row
	end

	def [](cell_index)
		@row[cell_index]
	end
end