module Grains
  module_function

  def square(num)
    unless (1..64).include? num
      raise ArgumentError, 'Number must be between 1 and 64'
    end

    grains[num]
  end

  def total
    grains.values.sum
  end

  def grains
    @grains ||= (1..64).each_with_object({}) do |n, hash|
      hash[n] = 2 ** (n - 1)
    end
  end
end
