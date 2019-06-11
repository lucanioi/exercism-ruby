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
      left_digits
        .each_index
        .count(&method(:same_value?)) * 10
    end

    private

    attr_reader :evaluated_equation

    def left_digits
      @left_digits ||= evaluated_equation.left.digits
    end

    def right_digits
      @right_digits ||= evaluated_equation.right.digits
    end

    def same_value?(i)
      left_digits[i] == right_digits[i]
    end
  end
end
