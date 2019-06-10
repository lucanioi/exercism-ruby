require_relative 'poker_hands'
require_relative 'card'

class Hand
  include Comparable

  attr_reader :cards, :str_array, :score

  def initialize(str_array)
    @cards = create_cards(str_array).map(&:freeze)
    validate_size!
    @score = PokerHands.calculate_score(self)
    freeze
  end

  def <=>(other)
    score <=> other.score
  end

  def to_a
    cards.map(&:to_s)
  end

  def values
    cards.map(&:value)
  end

  def suits
    cards.map(&:suit)
  end

  def highest_value
    values.max
  end

  private

  def create_cards(str_array)
    str_array.map do |str|
      Card.new(str)
    end
  end

  def validate_size!
    raise ArgumentError unless cards.size == 5
  end
end
