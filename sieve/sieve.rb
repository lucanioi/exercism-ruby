class Sieve
  def initialize(limit)
    @limit = limit
    mark_non_primes_false!
  end

  def primes
    indices_marked_true
  end

  private

  attr_reader :limit

  def mark_non_primes_false!
    (2..iteration_limit).each do |i|
      mark_multiples_false(i) if table[i]
    end
  end

  def indices_marked_true
    (2..limit).select { |i| table[i] }
  end

  def mark_multiples_false(i)
    (i**2..limit).step(i).each do |j|
      table[j] = false
    end
  end

  def table
    @table ||= [true] * (limit + 1)
  end

  def iteration_limit
    Math.sqrt(limit).floor
  end
end
