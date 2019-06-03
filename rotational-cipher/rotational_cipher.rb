module RotationalCipher
  UPPER = ('A'..'Z').to_a.freeze
  LOWER = ('a'..'z').to_a.freeze

  module_function

  def rotate(text, key)
    text.chars.map do |char|
      alphabet?(char) ? rotate_char(char, key) : char
    end.join
  end

  def rotate_char(char, key)
    alphabet = alphabet(char)
    alphabet[(alphabet.index(char) + key) % alphabet.size]
  end

  def alphabet?(char)
    (UPPER + LOWER).include?(char)
  end

  def alphabet(char)
    char.downcase == char ? LOWER : UPPER if alphabet?(char)
  end
end
