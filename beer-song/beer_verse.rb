
class BeerVerse
  DEFAULT_THIRD_SEGMENT = 'Take %s down and pass it around,'.freeze
  FINAL_THIRD_SEGMENT = 'Go to the store and buy some more,'.freeze

  def initialize(beer_count)
    validate!(beer_count)
    @beer_count = beer_count
  end

  def to_s
    <<~VERSE
      #{bottles.capitalize} of beer on the wall, \
      #{bottles} of beer.
      #{third_segment} #{bottles(-1)} of beer on the wall.
    VERSE
  end

  private

  attr_reader :beer_count

  def third_segment
    beer_count > 0 ? DEFAULT_THIRD_SEGMENT % take_down : FINAL_THIRD_SEGMENT
  end

  def bottles(diff = 0)
    bottles = (beer_count + diff) % 100
    case bottles
    when 2..99 then "#{bottles} bottles"
    when 1 then "#{bottles} bottle"
    when 0 then 'no more bottles'
    end
  end

  def take_down
    beer_count == 1 ? 'it' : 'one'
  end

  def validate!(beer_count)
    unless (0..99).include? beer_count
      raise ArgumentError, 'No more than 99, no less than 0!'
    end
  end
end
