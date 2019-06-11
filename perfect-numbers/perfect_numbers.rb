# frozen_string_literals: true

module PerfectNumber
  CLASSIFICATIONS = {
     0 => 'perfect',
     1 => 'abundant',
    -1 => 'deficient'
  }.freeze

  module_function

  def classify(number)
    raise RuntimeError if number <= 0
    CLASSIFICATIONS.fetch(aliquot_sum(number) <=> number)
  end

  def aliquot_sum(number)
    (2..Math.sqrt(number).round).reduce(1) do |sum, factor|
      (number % factor).zero? ? sum + factor + number / factor : sum
    end
  end
end

