class Trinary
  def initialize(trinary)
    @trinary = trinary
  end

  def to_decimal
    return 0 unless trinary =~ /\A[012]+\z/
    reverse_trinary = trinary.reverse

    (0...trinary.size).reduce(0) do |decimal, i|
      decimal + reverse_trinary[i].to_i * 3**i
    end
  end

  private

  attr_reader :trinary
end

module BookKeeping
  VERSION = 1
end
