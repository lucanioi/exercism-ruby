module Grep
  class File
    attr_reader :name

    def initialize(name, flags)
      @name = name
      @flags = flags
    end

    def grep(pattern)
      ::File.read(name).each_line.with_index
        .select { |line, _| pattern.match?(line) }
        .map(&method(:stylize))
        .join.chomp
    end

    private

    attr_reader :flags

    def stylize((line, index))
      flags.include?('-n') ? "#{index + 1}:#{line}" : line
    end
  end
end
