require_relative 'hand'

class Poker
  def initialize(hands)
    @hands = hands.map { |h| Hand.new(h) }
  end

  def best_hand
    hands.select { |h| h.score == hands.max.score }.map(&:to_a)
  end

  private

  attr_reader :hands
end
