class Triangle
  ROW_ONE = [1]

  attr_reader :rows

  def initialize(num_rows)
    @num_rows = num_rows
    @rows = build_rows
  end

  private

  attr_reader :num_rows

  def build_rows(rows = [ROW_ONE])
    return [] if num_rows <= 0
    return rows if rows.size == num_rows

    next_row = pad_row(rows.last).each_cons(2).map(&:sum)
    build_rows(rows << next_row)
  end

  def pad_row(row)
    [0] + row + [0]
  end
end