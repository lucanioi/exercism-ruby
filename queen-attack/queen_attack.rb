class Queens
  DEFAULT_POSITION = [0, 0].freeze

  def initialize(white:, black: DEFAULT_POSITION)
    @white = Position.new(*white)
    @black = Position.new(*black)
  end

  def attack?
    horizontally_aligned? ||
      vertically_aligned? ||
      diagonally_aligned?
  end

  private

  attr_reader :white, :black

  def horizontally_aligned?
    white.row == black.row
  end

  def vertically_aligned?
    white.column == black.column
  end

  def diagonally_aligned?
    (white.column - black.column).abs == (white.row - black.row).abs
  end
end

class Position
  COLUMNS = (0..7).freeze
  ROWS    = (0..7).freeze

  def initialize(row, column)
    @row    = row
    @column = column

    validate!
  end

  attr_reader :row, :column

  private

  def validate!
    unless COLUMNS.include?(column) && ROWS.include?(row)
      raise ArgumentError, 'Invalid position'
    end
  end
end
