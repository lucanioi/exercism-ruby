module House
  INTRO = 'This is the'.freeze
  ACTION = 'that %s the'.freeze
  FIRST_LINE = 'This is the house that Jack built.'.freeze
  CHARACTERS = [
    ['malt', 'lay in'],
    ['rat', 'ate'],
    ['cat', 'killed'],
    ['dog', 'worried'],
    ['cow with the crumpled horn', 'tossed'],
    ['maiden all forlorn', 'milked'],
    ['man all tattered and torn', 'kissed'],
    ['priest all shaven and shorn', 'married'],
    ['rooster that crowed in the morn', 'woke'],
    ['farmer sowing his corn', 'kept'],
    ['horse and the hound and the horn', 'belonged to']
  ].freeze

  module_function

  def recite
    verses.map { |verse| verse.join("\n") }.join("\n\n") + "\n"
  end

  def verses
    CHARACTERS.reduce([[FIRST_LINE]]) do |song, (character, verb)|
      first_line, *rest = song.last
      song << ["#{INTRO} #{character}", first_line.sub(INTRO, ACTION % verb), *rest]
    end
  end
end
