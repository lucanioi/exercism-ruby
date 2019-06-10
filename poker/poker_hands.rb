require_relative 'card'

module PokerHands
  extend self

  WEAKEST_TO_STRONGEST = %i(
    high_cards
    pairs
    three_of_a_kind
    straight
    flush
    full_house
    four_of_a_kind
    straight_flush
  ).freeze

  def calculate_score(hand)
    scores_by_hands =
      WEAKEST_TO_STRONGEST.reduce([]) do |scores, hand_type|
        scores + score(hand, as: hand_type)
      end

    combine_into_single_score(scores_by_hands)
  end

  private

  def calculations
    @calculations ||= {}
  end

  def score(hand, as:)
    Array calculations[as][:func].call(hand)
  end

  def combine_into_single_score(scores)
    scores.each_with_index.sum do |score, i|
      score * (Card::HIGHEST_VALUE + 1)**i
    end
  end

  def hand(name, &calculation)
    calculations[name] = { func: lambda(&calculation) }
  end

  hand :high_cards do |hand|
    hand.values.sort
  end

  hand :pairs do |hand|
    pair_1, pair_2 = find_duplicates(hand, 2)
    [(pair_1 || 0), (pair_2 || 0)]
  end

  hand :three_of_a_kind do |hand|
    find_duplicates(hand, 3).first || 0
  end

  hand :straight do |hand|
    values = values_for_straight(hand)
    values == (values.min..values.max).to_a ? values.max : 0
  end

  hand :flush do |hand|
    hand.suits.uniq.one? ? hand.values.max : 0
  end

  hand :full_house do |hand|
    three_of_a_kind = score(hand, as: :three_of_a_kind).first
    pair = score(hand, as: :pairs).find { |score| score != three_of_a_kind } || 0
    return [0, 0] if three_of_a_kind.zero? || pair.zero?
    [pair, three_of_a_kind]
  end

  hand :four_of_a_kind do |hand|
    find_duplicates(hand, 4).first || 0
  end

  hand :straight_flush do |hand|
    return 0 if score(hand, as: :straight).first.zero?
    score(hand, as: :flush)
  end

  def values_for_straight(hand)
    ace_low?(hand) ? to_ace_low(hand) : hand.values.sort
  end

  def find_duplicates(hand, count)
    hand.values.uniq.sort.select do |v|
      hand.values.count(v) == count
    end
  end

  def ace_low?(hand)
    [Card::LOWEST_VALUE, Card::HIGHEST_VALUE]
      .all? { |val| hand.values.include?(val) }
  end

  def to_ace_low(hand)
    [Card::LOW_ACE_VALUE] + hand.values.min(4)
  end
end
