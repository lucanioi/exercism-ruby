module Alphametics
  class FitnessFunction
    class << self
      def call(evaluated_equation)
        new(evaluated_equation).score
      end

      private :new
    end

    def initialize(evaluated_equation)
      @evaluated_equation = evaluated_equation
    end

    def score
      left_digits.each_index.reduce(0) do |score, i|
        left_digits[i] == right_digits[i] ? score + 10 : score
      end
    end

    private

    def left_digits
      @left_digits ||= evaluated_equation.left_hand_side.digits
    end

    def right_digits
      @right_digits ||= evaluated_equation.right_hand_side.digits
    end

    attr_reader :evaluated_equation
  end
end
