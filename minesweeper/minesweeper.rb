class Board
  CORNER = '+'.freeze
    MINE = '*'.freeze
   EMPTY = ' '.freeze

  VALID_CHARS = /[+*|\s]+/
   BORDER_ROW = /\+-*\+/
          ROW = /\|[\s*]*\|/

  class << self
    def transform(board)
      new(board).transform
    end

    private :new
  end

  def initialize(board)
    @board = board
    validate_board!
  end

  def transform
    board.dup.tap(&method(:transform_rows))
  end

  private

  attr_reader :board

  def validate_board!
    unless valid_form? && valid_composition?
      raise ArgumentError
    end
  end

  def valid_form?
    board.map(&:size).uniq.size == 1
  end

  def valid_composition?
    matcher = /#{BORDER_ROW}\n(?:#{ROW}\n)*#{BORDER_ROW}/
    !!(board.join("\n").match?(matcher))
  end

  def transform_rows(rows)
    rows.each_with_index do |row, row_i|
      next if row.start_with? CORNER

      transform_cells(row, row_i)
    end
  end

  def transform_cells(row, row_i)
    row.chars.each_with_index do |cell, col_i|
      next unless cell == EMPTY

      mines_count = count_adjacent_mines(row_i, col_i)
      board[row_i][col_i] =
        mines_count > 0 ? mines_count.to_s : EMPTY
    end
  end

  def count_adjacent_mines(row_i, col_i)
    surrounding_cells(row_i, col_i).count(MINE)
  end

  def surrounding_cells(row_i, col_i)
    [
      board[row_i - 1][col_i - 1],
      board[row_i - 1][col_i],
      board[row_i - 1][col_i + 1],
      board[row_i][col_i - 1],
      board[row_i][col_i + 1],
      board[row_i + 1][col_i - 1],
      board[row_i + 1][col_i],
      board[row_i + 1][col_i + 1],
    ]
  end
end
