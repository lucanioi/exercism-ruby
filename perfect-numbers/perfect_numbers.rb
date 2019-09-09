# frozen_string_literals: true

module PerfectNumber
  CLASSIFICATIONS = {
     0 => 'perfect',
     1 => 'abundant',
    -1 => 'deficient'
  }.freeze

  module_function

  def classify(n)
    raise RuntimeError if n <= 0
    CLASSIFICATIONS.fetch(aliquot_sum(n) <=> n)
  end

  def aliquot_sum(n)
    (2..Math.sqrt(n).round)
      .filter { |factor| (n % factor).zero? }
      .reduce(1) { |sum, factor| sum + factor + n / factor }
  end
end
