# frozen_string_literal: true

module RomanNumerals
  INT_TO_ROMAN = {
    1000 => 'M',
    900  => 'CM',
    500  => 'D',
    400  => 'CD',
    100  => 'C',
    90   => 'XC',
    50   => 'L',
    40   => 'XL',
    10   => 'X',
    9    => 'IX',
    5    => 'V',
    4    => 'IV',
    1    => 'I'
  }.freeze

  module_function

  def to_roman(int)
    return '' if int.zero?
    value = INT_TO_ROMAN.keys.select { |value| value <= int }.max
    INT_TO_ROMAN[value] + to_roman(int - value)
  end
end

class Integer
  def to_roman
    RomanNumerals.to_roman(self)
  end
end
