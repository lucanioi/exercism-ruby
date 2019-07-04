module Grains
  module_function

  def square(num)
    grains[num] || raise(ArgumentError)
  end

  def total
    grains.compact.sum
  end

  def grains
    @grains ||= (1..64).map { |n| 2 ** (n - 1) }.unshift(nil)
  end
end
