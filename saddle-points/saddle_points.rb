class Matrix
  def initialize(string)
    @string = string
    @matrix = build_matrix(string)
  end

  def rows
    matrix
  end

  def columns
    matrix.transpose
  end

  def saddle_points
    rows.each_with_object([]).with_index do |(row, saddle_points), row_i|
      row.each_with_index do |value, column_i|
        if value == row.max && value == columns[column_i].min
          saddle_points << [row_i, column_i]
        end
      end
    end
  end

  def to_s
    string
  end

  private

  attr_reader :matrix, :string

  def build_matrix(string)
    string.split("\n").map do |row|
      row.split.map(&:to_i)
    end
  end
end