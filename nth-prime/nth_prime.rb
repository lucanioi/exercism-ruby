class Prime
  include Enumerable

  class << self
    def nth(n)
      raise ArgumentError, 'n must be greater than 0' if n <= 0
      new.take(n).last
    end
  end

  def each(&block)
    (2..).each { |n| yield(n) if prime?(n) }
  end

  private

  def prime?(i)
    (2..Math.sqrt(i).to_i).none? do |divisor|
      i % divisor == 0
    end
  end
end
