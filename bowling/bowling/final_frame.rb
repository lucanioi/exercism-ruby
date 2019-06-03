require_relative 'frame'

module Bowling
  class FinalFrame < Frame
    MAX_ROLLS = 3

    def initialize
      super(nil)
    end

    def score
      score_error('Cannot calculate score until frame is over') unless closed?
      raw_score
    end

    def second_or_next_roll
      second_roll
    end

    private

    def closed?
      max_rolls? || flop?
    end

    def flop?
      rolls.size > 1 && first_roll + second_roll < max_pins
    end

    def first_throw_strike?
      strike?
    end

    def spare_in_bonus?
      rolls.size > 1 && second_roll < max_pins
    end

    def validate_roll(pins)
      roll_error("This frame is closed!") if closed?
      roll_error("Invalid roll: #{pins}") unless pins.between?(0, max_pins)

      if first_throw_strike? && spare_in_bonus?
        roll_error("Invalid roll: #{pins}") if second_roll + pins > max_pins
      end
    end
  end
end
