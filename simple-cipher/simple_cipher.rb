class Cipher
  attr_reader :key

  def initialize(key = nil)
    @key = key || generate_random_key
    validate_key!
  end

  def decode(text)
    text.chars.map.with_index do |char, i|
      decode_char(char, key[i])
    end.join
  end

  def encode(text)
    text.chars.map.with_index do |char, i|
      encode_char(char, key[i])
    end.join
  end

  private

  CHARACTERS = ('a'..'z').to_a
  VALID_KEY = /\A[a-z]+\z/

  def generate_random_key
    Array.new(100).map { |n| CHARACTERS.sample }.join
  end

  def validate_key!
    raise ArgumentError unless key =~ VALID_KEY
  end

  def encode_char(char, key_char)
    codec_char(*char_indeces(char, key_char))
  end

  def decode_char(char, key_char)
    base_index, key_index = char_indeces(char, key_char)
    codec_char(base_index, -key_index)
  end

  def char_indeces(*chars)
    chars.map { |char| CHARACTERS.index(char) }
  end

  def codec_char(base_index, key_index)
    offset = (base_index + key_index) % 26

    CHARACTERS[offset]
  end
end