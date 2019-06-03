module Pangram
  extend self

  LETTERS = ('a'..'z').to_a.freeze

  def pangram?(phrase, letters = LETTERS)
    letters.all? { |letter| phrase.include? letter }
  end
end

module BookKeeping
  VERSION = 6
end