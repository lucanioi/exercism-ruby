class Triplet
  DEFAULT_MIN = 1

  class << self
    def where(max_factor:, min_factor: DEFAULT_MIN, sum: nil)
      (min_factor..max_factor).to_a.combination(3).lazy
        .map { |nums| new(*nums) }
        .select(&:pythagorean?)
        .reject { |triplet| sum && triplet.sum != sum }
    end
  end

  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c
  end

  def sum
    a + b + c
  end

  def product
    a * b * c
  end

  def pythagorean?
    a**2 + b**2 == c**2
  end

  private

  attr_reader :a, :b, :c
end
