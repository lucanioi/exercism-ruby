require 'pry-byebug'
module Brackets
  extend self

  def paired?(string)
    Brackets.new(string).balanced?
  end

  class Brackets
    NilBracket = Class.new

    BRACKET_PAIRS = {
      '[' => ']',
      '(' => ')',
      '{' => '}'
    }.freeze

    def initialize(string)
      @brackets = extract_brackets(string)
    end

    def balanced?
      brackets.each_with_object([]) do |bracket, array|
        balances?(array.last, bracket) ? array.pop : array << bracket
      end.empty?
    end

    private

    attr_reader :brackets

    REGEXP = /[\[\](){}]/.freeze

    def balances?(open_bracket, close_bracket)
      BRACKET_PAIRS.fetch(open_bracket, '') == close_bracket
      # fetching with an empty string as default guards for cases where both are nil
    end

    def extract_brackets(string)
      string.scan(REGEXP)
    end
  end
end

module BookKeeping
  VERSION = 4
end
