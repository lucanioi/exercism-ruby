require_relative 'alphametics/genetic_algorithm'
require_relative 'alphametics/errors'
require_relative 'alphametics/config'

module Alphametics
  DEFAULT_CONFIG = Config.new(
    iterations: 1_000,
    pool_size: 700,
    selection_size: 50,
    survivor_count: 15,
    random_count: 5
  )

  class << self
    def solve(equation, config = nil)
      GeneticAlgorithm.new(equation, config: config || DEFAULT_CONFIG).solve
    rescue Errors::ValidationError
      {}
    end
  end
end
