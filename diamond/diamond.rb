# frozen_string_literal: true

module Diamond
  A = 'A'.ord

  class << self
    def make_diamond(char)
      create_quadrant(char)
        .map.with_index(&method(:create_row))
        .then(&method(:mirror))
        .join
    end

    private

    def create_quadrant(char)
      width = char.ord - A + 1
      Array.new(width) { "\s" * width }
    end

    def create_row(half_row, index)
      half_row[index] = (A + index).chr
      mirror(half_row.reverse) + "\n"
    end

    def mirror(data)
      data + data.reverse[1..-1]
    end
  end
end
