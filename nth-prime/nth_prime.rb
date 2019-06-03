class Prime
  def self.nth(num)
    new(num).compute
  end

  def initialize(num)
    raise ArgumentError, 'n must be greater than 0' if num <= 0

    @primes = [2]
    @num    = num
  end

  def compute
    current_num = primes.last + 1

    until primes.size == num
      if primes.none? { |prime| (current_num % prime).zero? }
        primes << current_num
        current_num = primes.last + 1
      else
        current_num += 1
      end
    end

    primes.last
  end

  private

  attr_reader :num, :primes
end

module BookKeeping
  VERSION = 1
end