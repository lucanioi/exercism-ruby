module Transpose
  class << self
    def transpose(input)
      to_matrix(input).transpose
        .map { |line| line.join.rstrip }
        .join("\n")
    end

    private

    def to_matrix(input)
      width = width(input)
      input.split("\n").reduce([]) do |matrix, line|
        matrix << pad(line.chars, ' ', width)
      end
    end

    def pad(array, fill, len)
      array.size >= len ? array : pad(array + [fill], fill, len)
    end

    def width(input)
      input.split("\n").max_by(&:length)&.length
    end
  end
end
