module Grep
  class File
    attr_reader :name

    def initialize(name, flags, include_file_name: false)
      @name = name
      @flags = flags
      @include_file_name = include_file_name
    end

    def grep(pattern)
      name_only? ? name_only(pattern) : all_lines(pattern)
    end

    private

    attr_reader :flags

    def name_only(pattern)
      pattern.match?(::File.read(name)) ? name : ''
    end

    def all_lines(pattern)
      all_matching_lines(pattern).join.chomp
    end

    def all_matching_lines(pattern)
      ::File.read(name).each_line.with_index
        .select { |line, _| pattern.match?(line) }
        .map(&method(:stylize))
    end

    def stylize((line, index))
      line = with_line_num? ? "#{index + 1}:#{line}" : line
      include_file_name? ? "#{name}:#{line}" : line
    end

    def with_line_num?
      flags.include?('-n')
    end

    def name_only?
      flags.include?('-l')
    end

    def include_file_name?
      @include_file_name
    end
  end
end
