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