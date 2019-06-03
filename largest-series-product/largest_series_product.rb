class Series
  DIGITS = /\A\d*\z/
  BASE_PRODUCT = 1

  def initialize(num_string)
    @num_string = num_string
    validate!
  end

  def largest_product(span)
    validate_span!(span)
    return BASE_PRODUCT if span.zero?

    largest_product = 0

    digits.each_cons(span) do |nums|
      product = nums.reduce(:*)
      largest_product = product if product > largest_product
    end

    largest_product
  end

  private

  attr_reader :num_string

  def digits
    num_string.to_i.digits
  end

  def validate!
    raise ArgumentError unless num_string =~ DIGITS
  end

  def validate_span!(span)
    raise ArgumentError unless span <= num_string.size
  end
end
