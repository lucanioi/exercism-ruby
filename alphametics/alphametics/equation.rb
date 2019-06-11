require_relative 'errors'
require_relative 'constraints'

module Alphametics
  class Equation
    EvaluatedEquation =
      Struct.new(:left, :right) do
        def error_margin
          (left - right).abs
        end
      end

    EQUALITY = '=='.freeze
    ADDITION = '+'.freeze

    attr_reader :constraint

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
      EvaluatedEquation.new(
        resolve_left(solution),
        resolve_right(solution)
      )
    end

    def uniq_letters
      equation.scan(/[[:alpha:]]/).uniq
    end

    def left
      equation.split(EQUALITY).first.strip
    end

    def right
      equation.split(EQUALITY).last.strip
    end

    def operands
      left.split(ADDITION).map(&:strip)
    end

    def resolve_left(solution)
      simplified_operands.reduce(0) do |accum, (op, mul)|
        accum + (substitute_term(op, solution) * mul)
      end
    end

    def resolve_right(solution)
      substitute_term(right, solution)
    end

    def substitute_term(term, solution)
      term.chars.map do |letter|
        solution.fetch(letter) do
          msg = "'#{letter}' could not be resolved"
          raise Errors::InvalidEquation, msg
        end
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
