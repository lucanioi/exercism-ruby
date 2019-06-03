require_relative 'constraints/single_operand'
require_relative 'constraints/double_operand'
require_relative 'constraints/multi_operand'

module Alphametics
  module Constraints
    module_function

    def for_equation(equation)
      case equation.operands.size
      when 1 then SingleOperand.new(equation)
      when 2 then DoubleOperand.new(equation)
      when 3.. then MultiOperand.new(equation)
      end
    end

    def empty
      EmptyConstraint
    end

    module EmptyConstraint
      module_function
      def valid?; true end
      def satisfy?(_); true end
      def negative_constraints; {}end
    end
  end
end
