class Squares
  def initialize(number)
    validate(number)
    @range = (1..number)
  end

  def square_of_sum
    @square_of_sum ||= compute_square_of_sum
  end

  def sum_of_squares
    @sum_of_squares ||= compute_sum_of_squares
  end

  def difference
    square_of_sum - sum_of_squares
  end

  private

  attr_reader :range

  def compute_square_of_sum
    range.sum ** 2
  end

  def compute_sum_of_squares
    range.reduce(0) { |sum, num| sum + num**2 }
  end

  def validate(number)
    unless number.is_a?(Integer) && number > 0
      raise ArgumentError, 'Value must be a positive integer'
    end
  end
end

