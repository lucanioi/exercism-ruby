module Atbash
  ALPHABET = ('a'..'z').to_a.freeze

  module_function

  def encode(string)
    string.downcase.scan(/\w/).map do |char|
      key.fetch(char, char)
    end.each_slice(5).map(&:join).join("\s")
  end

  def key
    @key ||= ALPHABET.zip(ALPHABET.reverse).to_h.freeze
  end
end
