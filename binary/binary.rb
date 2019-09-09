module Binary
  extend self

  def to_decimal(string)
    raise ArgumentError unless string =~ /^[01]+$/
    string.to_i(2)
  end
end


module BookKeeping
  VERSION = 3
end