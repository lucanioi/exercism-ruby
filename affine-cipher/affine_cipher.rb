class Affine
  NotCoprime = Class.new(ArgumentError)
  KeysNotFound = Class.new(StandardError)

  ALPHABET = ('a'..'z').to_a.map(&:freeze).freeze
  VALID_CHARS = /[a-z0-9]/
  M_VALUE = ALPHABET.size
  CHUNK_SIZE = 5

  ENCODE_FUNC = ->(x, a, b, m) { (a * x + b) % m }
  DECODE_FUNC = ->(y, a, b, m) do
    mmi = (0..m - 1).find { |n| (a * n) % m == 1 }
    (mmi * (y - b)) % m
  end

  attr_reader :key_a, :key_b

  def addkey(key_a, key_b)
    raise_coprime_error unless coprime?(key_a, M_VALUE)
    @key_a = key_a
    @key_b = key_b
  end

  def encode(string)
    chunk crypt(string, ENCODE_FUNC)
  end

  def decode(string)
    crypt(string, DECODE_FUNC)
  end

  private

  def crypt(string, func)
    ensure_keys_exist
    string.downcase
      .scan(VALID_CHARS)
      .map { |char| crypt_char(char, func) }
      .join
  end

  def chunk(string, size = CHUNK_SIZE)
    string.scan(/(?:.{#{size}})|(?:.+)/).join("\s")
  end

  def coprime?(key_a, m_value)
    (2..[key_a, m_value].min).none? do |factor|
      [key_a, m_value].all? { |num| num.modulo(factor).zero? }
    end
  end

  def crypt_char(char, cryption_func)
    return char unless ALPHABET.include?(char)
    enc_index = cryption_func.call(index_of(char), key_a, key_b, M_VALUE)
    ALPHABET[enc_index]
  end

  def index_of(char)
    ALPHABET.index(char)
  end

  def ensure_keys_exist
    raise KeysNotFound unless key_a && key_b
  end

  def raise_coprime_error
    raise NotCoprime, 'Error: a and m must be coprime.'
  end
end

