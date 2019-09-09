class Brackets
  BRACKET_MATCHER = /[\[\](){}]/
  BRACKET_PAIRS = {
    '[' => ']',
    '(' => ')',
    '{' => '}'
  }.freeze

  class << self
    def paired?(string)
      new(string).balanced?
    end

    private :new
  end

  def initialize(string)
    @brackets = string.scan(BRACKET_MATCHER).freeze
  end

  def balanced?
    brackets.each_with_object([]) do |bracket, array|
      balances?(array.last, bracket) ? array.pop : array << bracket
    end.empty?
  end

  private

  attr_reader :brackets

  def balances?(open_bracket, close_bracket)
    BRACKET_PAIRS.fetch(open_bracket, '') == close_bracket
  end
end
