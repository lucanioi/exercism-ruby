class Phrase
  def initialize(phrase)
    @words = phrase.scan(/\w+'?\w+|\d+/)
  end

  def word_count
    words.each_with_object(Hash.new(0)) do |word, dict|
      dict[word.downcase] += 1
    end
  end

  attr_reader :words
end
