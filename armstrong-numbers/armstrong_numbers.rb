module ArmstrongNumbers
  module_function

  def include?(number)
    digits = number.digits
    digits.sum { |d| d**digits.size } == number
  end
end
