
class Card
  include Comparable

  InvalidCard = Class.new(StandardError)

  LOWEST_VALUE = 1
  HIGHEST_VALUE = 13
  LOW_ACE_VALUE = 0
  RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze
  SUITS = %w(Spades Hearts Clubs Diamonds).map(&:chr).freeze

  attr_reader :rank, :suit

  def initialize(str)
    @rank = str.chop
    @suit = str[-1]
    validate!
  end

  def value
    RANKS.index(rank) + 1
  end

  def to_s
    rank + suit
  end

  def <=>(other)
    value <=> other.value
  end

  private

  def validate!
    unless RANKS.include?(rank) && SUITS.include?(suit)
      raise InvalidCard
    end
  end
end


