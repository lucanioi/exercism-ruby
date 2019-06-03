class Palindromes
  DEFAULT_MIN = 1

  Palindrome = Struct.new(:value, :factors)

  def initialize(max_factor:, min_factor: DEFAULT_MIN)
    @max_factor = max_factor
    @min_factor = min_factor
  end

  def generate
    @palindromes_and_factors ||= find_palindromes
  end

  def largest
    assure_generated!
    create_palindrome(palindromes.max)
  end

  def smallest
    assure_generated!
    create_palindrome(palindromes.min)
  end

  private

  def find_palindromes
    hash_with_array = Hash.new { |k, v| k[v] = [] }
    factor_pairs.each_with_object(hash_with_array) do |factor_pair, palindromes|
      product = factor_pair.reduce(:*)
      palindromes[product] << factor_pair if palindrome?(product)
    end
  end

  def factor_pairs
    numbers_in_range.repeated_combination(2)
  end

  def numbers_in_range
    (min_factor..max_factor).to_a
  end

  def palindrome?(number)
    number.to_s == number.to_s.reverse
  end

  def assure_generated!
    raise 'No palindromes generated!' unless palindromes_and_factors
  end

  def palindromes
    palindromes_and_factors.keys
  end

  def create_palindrome(palindrome)
    Palindrome.new(palindrome, factors_for(palindrome))
  end

  def factors_for(palindrome)
    palindromes_and_factors[palindrome]
  end

  attr_reader :max_factor, :min_factor, :palindromes_and_factors
end
