require_relative 'frame'

module Bowling
  class Game
    class BowlingError < StandardError; end

    MAX_FRAME = 10

    def initialize
      @frames = Frame.create_frames(MAX_FRAME)
      @current_frame = frames.first
    end

    def roll(pins)
      get_frame.roll(pins)
    rescue Frame::RollError => e
      bowling_error(e.message)
    end

    def score
      frames.map(&:score).sum
    rescue Frame::ScoreError => e
      bowling_error(e.message)
    end

    private

    attr_reader :frames, :current_frame

    def get_frame
      @current_frame = current_frame.proceed.tap do |frame|
        bowling_error("Stop throwing the ball it's over!") unless frame
      end
    end

    def bowling_error(message = nil)
      raise BowlingError, message
    end
  end
end

