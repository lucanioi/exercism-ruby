class Hexadecimal
  def initialize(string)
    @string = string
  end

  def to_decimal
    return 0 if string[/\H/]
    string.to_i(16)
  end

  private

  attr_reader :string
end