module Pangram
  LETTERS = ('a'..'z').to_a.freeze

  module_function

  def pangram?(phrase)
    (phrase.downcase.chars & LETTERS).size == LETTERS.size
  end
end
