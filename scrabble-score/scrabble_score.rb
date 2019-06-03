class Scrabble
  SCORES = {
    1  => %w(A E I O U L N R S T),
    2  => %w(D G),
    3  => %w(B C M P),
    4  => %w(F H V W Y),
    5  => %w(K),
    8  => %w(J X),
    10 => %w(Q Z)
  }.freeze

  class << self
    def score(word)
      new(word).score
    end
  end

  def initialize(word)
    @word = word.to_s
  end

  def score
    word.chars.reduce(0) { |score, char| score + table[char.upcase] }
  end

  private

  attr_reader :word

  def table
    @table ||= SCORES.reduce(Hash.new(0)) do |table, (score, letters)|
      letters.reduce(table) { |t, letter| t.merge(letter => score) }
    end
  end
end
