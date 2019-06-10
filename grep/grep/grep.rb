require_relative 'file'
require_relative 'pattern'
require_relative 'option'

module Grep
  class Grep
    def initialize(pattern, flags, file_names)
      @flags = flags.freeze
      @pattern = Pattern.with_flags(pattern, flags)
      @files = create_files(file_names, flags)
    end

    def grep
      files
        .map { |f| f.grep(pattern) }
        .join("\n")
    end

    private

    attr_reader :pattern, :flags, :files

    def create_files(file_names, flags)
      file_names.map { |name| File.new(name, flags) }
    end
  end
end
