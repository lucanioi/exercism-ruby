require_relative 'beer_verse'

module BeerSong
  module_function

  def recite(start, count)
    start.downto(start - count + 1).map(&method(:verse)).join("\n")
  end

  def verse(bottles)
    BeerVerse.new(bottles).to_s
  end
end
