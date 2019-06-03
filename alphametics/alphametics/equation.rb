require_relative 'errors'
require_relative 'constraints'

module Alphametics
  class Equation
    attr_reader :constraint

    EvaluatedEquation = Struct.new(:left_hand_side, :right_hand_side) do
      def error_margin
        (left_hand_side - right_hand_side).abs
      end
    end

    EQUALITY = '=='.freeze
    ADDITION = '+'.freeze

    def initialize(equation)
      @equation = equation.freeze
      @simplified_operands = combine_like_terms(operands)
      @constraint = Constraints.for_equation(self)
    end

    def to_s
      equation
    end

    def valid?
      constraint.valid?
    end

    def solve(solution)
      EvaluatedEquation.new(resolve_left_hand_side(solution), resolve_right_hand_side(solution))
    end

    def distinct_letters
      equation.scan(/[[:alpha:]]/).uniq
    end

    def left_hand_side
      equation.split(EQUALITY).first.strip
    end

    def right_hand_side
      equation.split(EQUALITY).last.strip
    end

    def operands
      left_hand_side.split(ADDITION).map(&:strip)
    end

    def sum_operands
      operands.map(&:to_i).sum
    end

    def resolve_left_hand_side(solution)
      simplified_operands.reduce(0) do |result, (operand, multiplier)|
        result + (substitute_term(operand, solution) * multiplier)
      end
    end

    def resolve_right_hand_side(solution)
      substitute_term(right_hand_side, solution)
    end

    def substitute_term(term, solution)
      term.chars.map do |letter|
        solution.fetch(letter) { raise Errors::InvalidEquation, "'#{letter}' could not be resolved" }
      end.join.to_i
    end

    private

    attr_reader :equation, :simplified_operands

    def substitute(mapping)
      self.class.new(equation.gsub(/[[:alpha:]]/, mapping))
    end

    def combine_like_terms(terms)
      terms.group_by(&:itself).transform_values(&:count)
    end
  end
end
