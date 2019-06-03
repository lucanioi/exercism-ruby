module IsbnVerifier
  DIGITS = %w[0 1 2 3 4 5 6 7 8 9 X].freeze
  LENGTH = 10

  module_function

  def valid?(isbn)
    valid_format?(isbn) && satisfies_formula?(isbn)
  end

  def valid_format?(isbn)
    isbn.delete('-').match?(/\A[0-9]{9}[0-9X]\z/)
  end

  def satisfies_formula?(isbn)
    isbn.scan(/\d|X/)
      .map { |char| DIGITS.index(char) }
      .each_with_index
      .sum { |n, i| n * (LENGTH - i) }
      .modulo(11)
      .zero?
  end
end
