# frozen_string_literal: true

class WordProblem
  OPERATIONS = {
    'plus' => :+,
    'minus' => :-,
    'multiplied by' => :*,
    'divided by' => :/
  }
  NUMBER = /-?\d+/

  def initialize(problem)
    @problem = problem
    @base, *@operands = extract_numbers
    @operations = extract_operations
  end

  def answer
    validate!(problem)
    operations.zip(operands)
      .reduce(base) do |base, (operation, operand)|
        base.send(operation, operand)
      end
  end

  private

  attr_reader :problem, :base, :operands, :operations

  def extract_numbers
    problem.scan(NUMBER).map(&:to_i)
  end

  def extract_operations
    problem.scan(operation_matcher)
      .map { |op| OPERATIONS.fetch(op) }
  end

  def operation_matcher
    /#{OPERATIONS.keys.join('|')}/
  end

  def validation_matcher
    /\AWhat is #{NUMBER}(?: #{operation_matcher} #{NUMBER})+\?\z/
  end

  def validate!(problem)
    unless problem.match?(validation_matcher)
      raise ArgumentError, "Invalid problem: \"#{problem}\""
    end
  end
end
