require_relative 'constraint'

module Alphametics
  module Constraints
    class MultiOperand < Constraint
      def valid?
        super && values_enough_to_satisfy?
      end

      private

      def find_negative_constraints
        super
          .then(&method(:add_ones_digit_constraints))
          .then(&method(:add_zero_by_exclusion))
      end

      def values_enough_to_satisfy?
        return true if letters.size < 10

        POSSIBLE_VALUES.none? do |value|
          POSSIBLE_VALUES.count ==
            all_constrainted_values.count(value)
        end
      end

      def add_ones_digit_constraints(mapping)
        mapping.dup.tap do |mapping|
          if digits_at(0, all_terms).uniq.one?
            constraint = POSSIBLE_VALUES.select do |n|
              (n * operands.count) % 10 == n
            end
            mapping[digit_at(0, result)] += constraint
          end
        end
      end

      def add_zero_by_exclusion(mapping)
        mapping.dup.tap do |mapping|
          if leading_letters.size == 9
            zero_letter = (letters - leading_letters).first
            mapping[zero_letter] += (1..9).to_set
          end
        end
      end

      def all_constrainted_values
        negative_constraints.values.map(&:to_a).flatten
      end
    end
  end
end
