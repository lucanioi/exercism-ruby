# frozen_string_literal: true
require_relative 'invalid_codon_error'

module Translation
  PROTEINS_TO_CODONS = {
    Cysteine:      %w[UGU UGC],
    Leucine:       %w[UUA UUG],
    Methionine:    %w[AUG],
    Phenylalanine: %w[UUU UUC],
    Serine:        %w[UCU UCC UCA UCG],
    Tryptophan:    %w[UGG],
    Tyrosine:      %w[UAU UAC],
    STOP:          %w[UAA UAG UGA]
  }.freeze

  module_function

  def of_codon(cod)
    codons_to_proteins.fetch(cod) { raise InvalidCodonError }
  end

  def of_rna(strand)
    strand.chars.each_slice(3)
      .map { |nucs| of_codon(nucs.join) }
      .take_while { |pro| pro != 'STOP' }
  end

  def codons_to_proteins
    @codons_to_proteins ||=
      PROTEINS_TO_CODONS.reduce({}) do |hash, (pro, cods)|
        cods.reduce(hash) { |h, cod| h.merge(cod => pro.to_s) }
      end
  end
end
