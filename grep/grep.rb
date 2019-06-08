require_relative 'grep/grep'

module Grep
  class << self
    def grep(pattern, flags, files)
      Grep.new(pattern, flags, files).grep
    end
  end
end
