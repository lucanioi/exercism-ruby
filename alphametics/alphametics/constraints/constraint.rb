module Alphametics
  module Constraints
    class Constraint
      POSSIBLE_VALUES = (0..9).to_a.freeze

      def initialize(equation)
        @operands = equation.operands
        @result   = equation.right_hand_side
        @letters  = equation.distinct_letters
      end

      def negative_constraints
        @negative_constraints ||= find_negative_constraints
      end

      def satisfy?(mapping)
        negative_constraints.none? { |letter, values| values.include? mapping[letter]  }
      end

      def valid?
        negative_constraints.none? { |_, values| values.size == POSSIBLE_VALUES.count } &&
          !(operands.size > 1 && operands.include?(result))
      end

      private

      attr_reader :result, :operands, :letters

      def find_negative_constraints
        empty_mapping
          .then(&method(:add_leading_zero_constraint))
          .then(&method(:add_leading_result_digit))
      end

      def add_leading_zero_constraint(mapping)
        mapping.dup.tap do |mapping|
          leading_letters.each do |letter|
            mapping[letter] << 0
          end
        end
      end

      def add_leading_result_digit(mapping)
        mapping.dup.tap do |mapping|
          mapping[leading_result_letter] +=
            (0...min_leading_result).to_a +
            (max_leading_result + 1..9).to_a
        end
      end

      def max_leading_result
        max_result = substitute_max(operands).map(&:to_i).sum
        max_leading_digit = max_result / result_power_of_ten
        max_leading_digit < 10 ? max_leading_digit : 9
      end

      def min_leading_result
        min_result = substitute_min(operands).map(&:to_i).sum
        min_result / result_power_of_ten
      end

      def substitute_max(terms)
        terms.map { |term| '9' * term.size }
      end

      def substitute_min(terms)
        terms.map { |term| '1'.ljust(term.size, '0') }
      end

      def leading_letters
        all_terms.map(&:chr).uniq
      end

      def result_power_of_ten
        10 ** (result.size - 1)
      end

      def leading_result_letter
        result.chr
      end

      def all_terms
        [*operands, result]
      end

      def digits_at(position, terms)
        terms.map(&method(:digit_at).curry[position])
      end

      def digit_at(position, num_string)
        num_string.reverse[position]
      end

      def empty_mapping
        Hash.new { |h, k| h[k] = Set.new }
      end
    end
  end
end
