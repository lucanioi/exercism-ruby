module BaseConverter
  module_function

  def convert(input_base, digits, output_base)
    validate_inputs!(input_base, digits, output_base)

    convert_to_base_10(digits, input_base)
      .then { |decimal| convert_from_base_10(decimal, output_base) }
      .then { |output| output.empty? ? [0] : output }
  end

  def convert_to_base_10(digits, base)
    digits.reverse.each_with_index.reduce(0) do |sum, (digit, index)|
      sum + digit * base**index
    end
  end

  def convert_from_base_10(decimal, base, digits = [])
    return digits if decimal == 0
    convert_from_base_10(decimal / base, base, digits.prepend(decimal % base))
  end

  def validate_inputs!(input_base, digits, output_base)
    unless input_base > 1 &&
            output_base > 1 &&
            (digits.min || 0) >= 0 &&
            (digits.max || 0) < input_base
      raise ArgumentError
    end
  end
end
