class Triangle
  module InvalidTriangle
    def equilateral?; false end
    def isosceles?; false end
    def scalene?; false end
  end

  def initialize(sides)
    @sides = sides.freeze
    extend InvalidTriangle unless valid?
  end

  def equilateral?
    sides.uniq.one?
  end

  def isosceles?
    sides.uniq.size <= 2
  end

  def scalene?
    !isosceles?
  end

  private

  attr_reader :sides

  def valid?
    sides_positive? && sides_connect?
  end

  def sides_positive?
    sides.all?(&:positive?)
  end

  def sides_connect?
    sides.each_with_index.all? do |side, i|
      side <= sides[i - 1] + sides[i - 2]
    end
  end
end
