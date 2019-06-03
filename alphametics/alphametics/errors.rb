module Alphametics
  module Errors
    Error = Class.new(StandardError)
    ValidationError = Class.new(Error)

    TimeOut = Class.new(Error)
    ImpossibleConstraints = Class.new(ValidationError)
    InvalidEquation = Class.new(ValidationError)
    InvalidChromosome = Class.new(ValidationError)
  end
end
