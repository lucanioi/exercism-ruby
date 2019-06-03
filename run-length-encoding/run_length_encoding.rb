module RunLengthEncoding
  module_function

  def encode(input)
    input.gsub(/(.)\1+/) { |str| "#{str.length}#{str[0]}" }
  end

  def decode(input)
    input.gsub(/\d+./) { |str| str[-1] * str.to_i }
  end
end
