module Bowling
  class Frame
    class ScoreError < StandardError; end
    class RollError < StandardError; end

    MAX_PINS = 10
    MAX_ROLLS  = 2

    class << self
      def create_frames(size)
        require_relative 'final_frame'
        (size - 1).times.reduce([FinalFrame.new]) do |frames|
          [new(frames.first)] + frames
        end
      end
    end

    def initialize(next_frame)
      @next_frame = next_frame
      @rolls = []
    end

    def roll(pins)
      validate_roll(pins)
      rolls << pins
    end

    def score
      score_error('Cannot calculate score until frame is over') unless closed?
      return score_for_strike if strike?
      return score_for_spare  if spare?
      raw_score
    end

    def proceed
      closed? ? next_frame : self
    end

    protected

    def first_roll
      rolls[0] || 0
    end

    def second_or_next_roll
      strike? ? next_frame.first_roll : second_roll
    end

    private

    attr_reader :next_frame, :rolls

    def second_roll
      rolls[1] || 0
    end

    def raw_score
      rolls.sum
    end

    def score_for_strike
      raw_score + next_frame.first_roll + next_frame.second_or_next_roll
    end

    def score_for_spare
      raw_score + next_frame.first_roll
    end

    def strike?
      first_roll == max_pins
    end

    def spare?
      !strike? && raw_score == max_pins
    end

    def closed?
      strike? || max_rolls?
    end

    def max_rolls?
      rolls.size >= max_rolls
    end

    def max_rolls
      self.class::MAX_ROLLS
    end

    def max_pins
      self.class::MAX_PINS
    end

    def validate_roll(pins)
      roll_error("This frame is closed!") if closed?
      roll_error("Invalid roll: #{pins}") unless pins.between?(0, max_pins)
      roll_error("Cannot score more than #{max_pins}!") if raw_score + pins > max_pins
    end

    def score_error(message = nil)
      raise ScoreError, message
    end

    def roll_error(message = nil)
      raise RollError, message
    end
  end
end
