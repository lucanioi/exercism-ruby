require_relative 'card'

module PokerHands
  extend self

  SCORE_BASE = 14
  HANDS_IN_ORDER = %i(
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
      HANDS_IN_ORDER.reduce([]) do |scores, hand_type|
        scores + score(hand, as: hand_type)
      end

    combine_into_single_score(scores_by_hands)
  end

  private

  def calculations
    @calculations ||= {}
  end

  def score(hand, as:)
    Array(calculations[as][:func].call(hand) || 0)
      .map { |score| score ? score : 0 }
  end

  def combine_into_single_score(scores)
    scores.each_with_index.sum do |score, i|
      score * SCORE_BASE**i
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
    [pair_1, pair_2]
  end

  hand :three_of_a_kind do |hand|
    find_duplicates(hand, 3).first
  end

  hand :straight do |hand|
    values = values_for_straight(hand)
    values.max if sequence?(values)
  end

  hand :flush do |hand|
    hand.highest_value if single_suite?(hand)
  end

  hand :full_house do |hand|
    set = score(hand, as: :three_of_a_kind).first
    pair = score(hand, as: :pairs).first
    [set, pair].none?(&:zero?) ? [pair, set] : [0, 0]
  end

  hand :four_of_a_kind do |hand|
    find_duplicates(hand, 4).first
  end

  hand :straight_flush do |hand|
    if score(hand, as: :straight).first.nonzero?
      score(hand, as: :flush)
    end
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
    ['2', 'A'].all? { |rank| hand.ranks.include?(rank) }
  end

  def to_ace_low(hand)
    [Card::LOW_ACE_VALUE] + hand.values.min(4)
  end

  def sequence?(values)
    values.sort == (values.min..values.max).to_a
  end

  def single_suite?(hand)
    hand.suits.uniq.one?
  end
end
