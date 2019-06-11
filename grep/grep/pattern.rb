module Grep
  class Pattern
    def initialize(pattern, flags)
      @pattern = pattern
      @flags = flags
    end

    def match?(string)
      string.match?(pattern)
        .then { |matched| invert? ? !matched : matched  }
    end

    def pattern
      option = ignore_case? ? Regexp::IGNORECASE : 0
      Regexp.new(regexp(@pattern), option)
    end

    private

    attr_reader :flags

    def regexp(pattern)
      match_whole_line? ? "^#{pattern}$" : pattern
    end

    def ignore_case?
      flags.include?('-i')
    end

    def invert?
      flags.include?('-v')
    end

    def match_whole_line?
      flags.include?('-x')
    end
  end
end
