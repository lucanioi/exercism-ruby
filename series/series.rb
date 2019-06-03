class Series
  def initialize(digits)
    @digits = digits
  end

  def slices(slice_size)
    raise ArgumentError if slice_size > digits.size
    digits.chars.each_cons(slice_size).map(&:join)
  end

  private

  attr_reader :digits
end
