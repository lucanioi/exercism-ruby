require 'pry-byebug'

module PrimeFactors
  module_function

  def for(num)
    return [] if num == 1
    prime_factor = (2..num).find { |prime| (num % prime).zero? }
    [prime_factor] + self.for(num / prime_factor)
  end
end
