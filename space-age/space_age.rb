class SpaceAge
  EARTH_YEAR = 31557600.0
  SPACE_AGES = {
    earth:   1.0,
    mercury: 0.2408467,
    venus:   0.61519726,
    mars:    1.8808158,
    jupiter: 11.862615,
    saturn:  29.447498,
    uranus:  84.016846,
    neptune: 164.79132
  }.freeze

  SPACE_AGES.keys.each do |planet|
    define_method("on_#{planet}") do
      get_space_age(SPACE_AGES[planet.to_sym])
    end
  end

  def initialize(seconds)
    @seconds = seconds
  end

  private

  attr_reader :seconds

  def get_space_age(earth_years)
    seconds / to_seconds(earth_years)
  end

  def to_seconds(earth_years)
    EARTH_YEAR * earth_years
  end
end
