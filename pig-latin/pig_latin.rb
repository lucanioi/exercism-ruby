module PigLatin
  VOWELS_REGEXP = /[aeio]|y(?:[^aeiou]|\b)|(?<!q)u|\Ax[^aeiou]/
  PIGTAIL = 'ay'.freeze

  class << self
    def translate(phrase)
      phrase.split.map do |word|
        to_pig_latin(word.downcase)
      end.join("\s")
    end

    private

    def to_pig_latin(word)
      vowel_index = word =~ VOWELS_REGEXP
      word[vowel_index...word.size] + word[0...vowel_index] + PIGTAIL
    end
  end
end
