require 'set'

class Robot
  POSSIBLE_COMBOS = 676_000
  POSSIBLE_NUMERIC_COMBOS = 1000
  ALPHABET = ('A'..'Z').to_a.freeze

  class << self
    OutOfUniqueNames = Class.new(StandardError)

    def forget
      registry.clear
    end

    def generate_unique_name
      unique_number = unique_random_number
      register_number(unique_number)
      (prefix(unique_number) + suffix(unique_number)).freeze
    end

    private

    def registry
      @registry ||= Set.new
    end

    def unique_random_number
      out_of_unique_names! if registry.size >= POSSIBLE_COMBOS
      number = random_number
      number = random_number while registry.include?(number)
      number
    end

    def random_number
      rand(0...POSSIBLE_COMBOS)
    end

    def register_number(number)
      registry.add(number)
    end

    def prefix(number)
      first, second = (number / POSSIBLE_NUMERIC_COMBOS).divmod(ALPHABET.size)
      ALPHABET[first] + ALPHABET[second]
    end

    def suffix(number)
      (number % POSSIBLE_NUMERIC_COMBOS).to_s.rjust(3, '0')
    end

    def out_of_unique_names!
      raise OutOfUniqueNames, 'Ran out of unique names!'
    end
  end

  def name
    @name ||= self.class.generate_unique_name
  end

  def reset
    @name = nil
  end
end
