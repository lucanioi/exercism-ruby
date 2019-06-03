# frozen_string_literal: true

module TwelveDays
  INTRO = 'On the %s day of Christmas my true love gave to me:'
  DAYS = %w[first second third fourth fifth
            sixth seventh eighth ninth tenth
            eleventh twelfth]
  GIFTS = %w[
    twelve\ Drummers\ Drumming
    eleven\ Pipers\ Piping
    ten\ Lords-a-Leaping
    nine\ Ladies\ Dancing
    eight\ Maids-a-Milking
    seven\ Swans-a-Swimming
    six\ Geese-a-Laying
    five\ Gold\ Rings
    four\ Calling\ Birds
    three\ French\ Hens
    two\ Turtle\ Doves
    a\ Partridge\ in\ a\ Pear\ Tree
  ].freeze

  class << self
    def song
      (0...DAYS.size).map(&method(:verse)).join("\n")
    end

    def verse(num)
      gifts = GIFTS.last(num + 1)
      "#{INTRO} #{concat(gifts)}.\n" % DAYS[num]
    end

    def concat(words)
      return words.join if words.size <= 1
      "#{words[0..-2].join(', ')}, and #{words.last}"
    end
  end
end
