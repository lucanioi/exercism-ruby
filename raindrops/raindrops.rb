# frozen_string_literal: true

module Raindrops
  TABLE = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }.freeze

  class << self
    def convert(num)
      translate(num).then { |t| t.empty? ? num.to_s : t }
    end

    private

    def translate(num)
      TABLE.keys.reduce('') do |str, factor|
        factor?(num, factor) ? str + TABLE[factor] : str
      end
    end

    def factor?(num, factor)
      num % factor == 0
    end
  end
end
