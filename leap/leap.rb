module Year
  extend self

  def leap?(year)
    return false unless divisible_by_4?(year)
    return false if divisible_by_100?(year) unless divisible_by_400?(year)
    true
  end

  private

  def divisible_by_4?(number)
    (number % 4).zero?
  end

  def divisible_by_100?(number)
    (number % 100).zero?
  end

  def divisible_by_400?(number)
    (number % 400).zero?
  end
end

module BookKeeping
  VERSION = 3
end
