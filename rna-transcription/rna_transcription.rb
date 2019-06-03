module Complement
  InvalidNucleotide = Class.new(StandardError)

  COMPLEMENTS = {
    'G' => 'C',
    'C' => 'G',
    'T' => 'A',
    'A' => 'U'
  }.freeze

  module_function

  def of_dna(dna)
    dna.chars.map(&method(:find_complement)).join
  end

  def find_complement(nucl)
    COMPLEMENTS.fetch(nucl) do
      raise InvalidNucleotide, "'#{nucl}'"
    end
  end
end
