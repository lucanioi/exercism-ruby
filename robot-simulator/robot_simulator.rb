require_relative 'simulator'

class Robot
  DIRECTIONS = [:north, :east, :south, :west]

  attr_reader :coordinates

  def initialize
    @bearing = 0
    @coordinates = [0, 0]
  end

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include? direction
    @bearing = DIRECTIONS.index(direction)
  end

  def bearing
    DIRECTIONS[@bearing]
  end

  def turn_right
    @bearing += 1
    @bearing %= 4
    bearing
  end

  def turn_left
    @bearing -= 1
    @bearing %= 4
    bearing
  end

  def at(*coordinates)
    @coordinates = coordinates
  end

  def advance
    case @bearing
    when 0 then @coordinates[1] += 1
    when 1 then @coordinates[0] += 1
    when 2 then @coordinates[1] -= 1
    when 3 then @coordinates[0] -= 1
    end
    @coordinates
  end
end
