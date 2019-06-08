module Grep
  class Grep
    def initialize(pattern, flags, files)
      @pattern = pattern
      @flags = flags
      @files = files
    end

    def grep
      files
        .flat_map { |file| File.read(file).lines.map(&:chomp) }
        .select { |line| line.match?(/#{pattern}/) }
        .join("\n")
    end

    private

    attr_reader :pattern, :flags, :files

    def method_name

    end
  end
end
