class SumOfMultiples
  def initialize(*factors)
    @factors = factors
  end

  def to(num)
    (factors.min || 0...num)
      .select(&method(:multiple?))
      .sum
  end

  private

  attr_reader :factors

  def multiple?(num)
    factors
      .reject(&:zero?)
      .any? { |factor| (num % factor).zero? }
  end
end
