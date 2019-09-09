module Raindrops
  extend self

  TABLE = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }.freeze

  def convert(num)
    translation = translate(num)

    translation.empty? ? num.to_s : translation
  end

  private

  def translate(num)
    TABLE.keys.each_with_object('') do |factor, str|
      str << TABLE[factor] if factor?(num, factor)
    end
  end

  def factor?(num, factor)
    num % factor == 0
  end
end

module BookKeeping
  VERSION = 3
end