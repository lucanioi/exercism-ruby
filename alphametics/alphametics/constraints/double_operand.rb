require_relative 'constraint'

module Alphametics
  module Constraints
    class DoubleOperand < Constraint
      private

      def find_negative_constraints
        super.then(&method(:add_additive_id))
      end

      def add_additive_id(mapping)
        mapping.dup.tap do |mapping|
          (0...min_term_length).each do |position|
            add_additive_id_at(position, mapping)
          end
        end
      end

      def add_additive_id_at(position, mapping)
        op_1, op_2 = digits_at(position, operands)
        result_digit = digit_at(position, result)

        if [op_1, op_2].include?(result_digit)
          letter = op_1 == result_digit ? op_2 : op_1
          mapping[letter] += additive_id_constraint(position)
        end
      end

      def additive_id_constraint(position)
        position == 0 ? (1..9).to_set : (1..8).to_set
      end

      def min_term_length
        all_terms.min_by(&:length).length
      end
    end
  end
end

