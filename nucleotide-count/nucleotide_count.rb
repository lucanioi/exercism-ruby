module Nucleotide
  extend self

  def from_dna(dna)
    NucleoTideCounter.new(dna)
  end

  class NucleoTideCounter
    HISROGRAM_TEMPLATE = {
      'A' => 0,
      'T' => 0,
      'C' => 0,
      'G' => 0
    }.freeze

    def initialize(dna)
      validate(dna)
      @dna = dna
    end

    def count(nucl)
      dna.count(nucl)
    end

    def histogram
      @histogram ||= create_histogram
    end

    private

    def create_histogram
      dna.each_char.with_object(copy_template) do |char, histogram|
        histogram[char] += 1
      end
    end

    def validate(dna)
      unless dna.chars.all? { |char| HISROGRAM_TEMPLATE.key? char }
        raise ArgumentError, 'Nucleotides must be either A, G, T, or C'
      end
    end

    def copy_template
      HISROGRAM_TEMPLATE.dup
    end

    attr_reader :dna
  end
end