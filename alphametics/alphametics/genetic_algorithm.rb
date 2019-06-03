require_relative 'equation'
require_relative 'chromosome'
require_relative 'errors'
require_relative 'fitness_function'
require_relative 'config'

module Alphametics
  class GeneticAlgorithm
    def initialize(equation, config:)
      @equation = Equation.new(equation).freeze
      @config = config
      setup!
    end

    def solve
      config.iterations.times do
        if chromosome = gene_pool.find { |chrom| error_margin(chrom).zero? }
          return chromosome.to_solution
        end
        repopulate_pool(next_generation)
      end

      raise Errors::TimeOut, "Failed to find a solution within #{config.iterations} iterations."
    end

    private

    attr_reader :equation, :gene_pool, :config

    def setup!
      validate_equation!
      set_constraints
      @gene_pool = random_chromosomes(config.pool_size)
    end

    def next_generation
      select_fittest(gene_pool) + gene_pool.sample(config.survivor_count) + random_chromosomes(config.random_count)
    end

    def random_chromosomes(count)
      count.times.map { Chromosome.random_chromosome(equation.distinct_letters) }
    end

    def select_fittest(pool)
      pool.max_by(config.selection_size, &method(:fitness))
    end

    def repopulate_pool(selected_gene_pool)
      @gene_pool = config.pool_size.times.map { selected_gene_pool.sample.mutated_copy }
    end

    def error_margin(chromosome)
      solve_equation_with(chromosome).error_margin
    end

    def fitness(chromosome)
      FitnessFunction.call(solve_equation_with(chromosome))
    end

    def solve_equation_with(chromosome)
      equation.solve(chromosome.to_solution)
    end

    def set_constraints
      Chromosome.constraint = equation.constraint
    end

    def average_fitness
      gene_pool.map(&method(:fitness)).sum / gene_pool.size.to_f
    end

    def validate_equation!
      unless equation.valid?
        raise Errors::InvalidEquation
      end
    end
  end
end
