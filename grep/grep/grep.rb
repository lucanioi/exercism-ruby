require_relative 'file'
require_relative 'pattern'

module Grep
  class Grep
    def initialize(pattern, flags, file_names)
      @flags = flags.freeze
      @pattern = Pattern.new(pattern, flags)
      @files = create_files(file_names, flags)
    end

    def grep
      files.map { |f| f.grep(pattern) }.reject(&:empty?).join("\n")
    end

    private

    attr_reader :pattern, :flags, :files

    def create_files(file_names, flags)
      file_names.map do |name|
        File.new(name, flags,
                 include_file_name: file_names.size > 1)
      end
    end
  end
end
