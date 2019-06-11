require_relative 'constraint'

module Alphametics
  module Constraints
    class SingleOperand < Constraint
      private

      def find_negative_constraints
        super.then(&method(:check_inequality))
      end

      def check_inequality(mapping)
        mapping.dup.tap do |mapping|
          unless equal_terms
            letters.each do |letter|
              mapping[letter] += POSSIBLE_VALUES.to_set
            end
          end
        end
      end

      def operand
        operands.first
      end

      def equal_terms
        operand == result
      end
    end
  end
end
