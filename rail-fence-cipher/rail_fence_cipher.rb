module RailFenceCipher
  class << self
    def encode(string, height)
      rail_fence(height, string.chars).join
    end

    def decode(string, height)
      (rail_fence(height, 0...string.length))
        .zip(string.chars)
        .sort.map(&:last)
        .join
    end

    private

    def rail_fence(height, elements)
      ((0..height - 1).to_a + (height - 2).downto(1).to_a)
        .cycle.first(elements.size)
        .zip(elements)
        .sort_by.with_index { |(rail, _), i| [rail, i] }
        .map(&:last)
    end
  end
end
