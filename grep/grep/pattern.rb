module Grep
  class Pattern
    # in order of precedence
    STRATEGIES = {
      '-i'
      '-v'
      '-x'
    }

    class << self
      def with_flags(pattern, flags)

      end
    end

    def initialize(pattern)
      @pattern = pattern
    end

    def match?(string)
      string.match?(pattern)
    end

    def pattern
      case_sensitive? ? /#{@pattern}/ : /#{@pattern}/i
    end

    private

    attr_reader :flags

    def case_sensitive?
      !flags.include?('-i')
    end
  end
end
