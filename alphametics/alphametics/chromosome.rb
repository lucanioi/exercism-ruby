require_relative 'errors'
require_relative 'constraints'

module Alphametics
  class Chromosome
    FILLER_GENE = '_'.freeze
    DIVERSITY = 10

    attr_reader :genes

    class << self
      attr_writer :invalid_solutions, :constraint

      def random_chromosome(letters)
        new(create_genes(letters).shuffle)
      rescue Errors::InvalidChromosome
        retry
      end

      def constraint
        @constraint ||= Constraints.empty
      end

      def reset_constraint
        @constraint = Constraints.empty
      end

      private

      def create_genes(letters)
        letters.dup.fill(FILLER_GENE, letters.size...DIVERSITY)
      end
    end

    def initialize(genes)
      @genes = genes.freeze
      validate_genes!
      validate_genetic_mutability!
    end

    def to_solution
      map_genes_to_indices(genes)
    end

    def to_s
      genes.join(' ')
    end

    def mutated_copy
      genes.dup
        .tap { |genes| mutate!(genes, *mutation_indices) }
        .then { |genes| self.class.new(genes) }
    end

    def ==(other)
      self.class == other.class && genes == other.genes
    end

    private

    def map_genes_to_indices(genes)
      genes.zip(genes.each_index).to_h
       .tap { |chrom| chrom.delete(FILLER_GENE) }
    end

    def mutate!(genes, ind_1, ind_2)
      genes[ind_1], genes[ind_2] = genes[ind_2], genes[ind_1]
    end

    def mutation_indices
      ind_1, ind_2 = generate_random_indices
      until valid_swap?(ind_1, ind_2)
        ind_1, ind_2 = generate_random_indices
      end
      [ind_1, ind_2]
    end

    def valid_swap?(ind_1, ind_2)
      ind_1 != ind_2 &&
        swap_includes_letters?(ind_1, ind_2) &&
        valid_mutation?(ind_1, ind_2)
    end

    def swap_includes_letters?(ind_1, ind_2)
      [ind_1, ind_2].any? { |i| genes[i] != FILLER_GENE }
    end

    def valid_mutation?(ind_1, ind_2)
      genes.dup
        .tap { |genes| mutate!(genes, ind_1, ind_2) }
        .then(&method(:map_genes_to_indices))
        .then(&method(:satisfy_constraint?))
    end

    def satisfy_constraint?(solution)
      constraint.satisfy?(solution)
    end

    def generate_random_indices
      [rand(DIVERSITY), rand(DIVERSITY)]
    end

    def constraint
      self.class.constraint
    end

    def validate_genes!
      unless satisfy_constraint?(to_solution)
        raise Errors::InvalidChromosome
      end
    end

    def validate_genetic_mutability!
      unless genetically_mutable?
        raise Errors::ImpossibleConstraints
      end
    end

    def genetically_mutable?
      (0...DIVERSITY).to_a.combination(2).any? do |indices|
        valid_mutation?(*indices)
      end
    end
  end
end
