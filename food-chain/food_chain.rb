# frozen_string_literal: true

module FoodChain
  FIRST_LINE = 'I know an old lady who swallowed a %s.'
  BODY_LINE  = 'She swallowed the %s to catch the %s.'
  LAST_LINE  = 'I don\'t know why she swallowed the %s. ' \
               'Perhaps she\'ll die.'
  LAST_LINE_FINAL_VERSE = 'She\'s dead, of course!'

  ANIMALS = {
    'fly'    => '',
    'spider' => 'It wriggled and jiggled and tickled inside her.',
    'bird'   => 'How absurd to swallow a bird!',
    'cat'    => 'Imagine that, to swallow a cat!',
    'dog'    => 'What a hog, to swallow a dog!',
    'goat'   => 'Just opened her throat and swallowed a goat!',
    'cow'    => 'I don\'t know how she swallowed a cow!',
    'horse'  => ''
  }.freeze

  module_function

  def song
    animals.map(&method(:verse)).join("\n\n") + "\n"
  end

  def verse(animal)
    [first_line(animal),
     body(animal),
     last_line(animal)].compact.join("\n")
  end

  def first_line(animal)
    FIRST_LINE % animal
  end

  def body(animal)
    unless [animals.first, animals.last].include?(animal)
      "#{ANIMALS[animal]}\n" +
      animals_until(animal).reverse.each_cons(2)
        .map(&method(:body_line)).join("\n")
    end
  end

  def body_line((swallowed, to_catch))
    to_catch = "#{to_catch}#{description(to_catch)}"
    BODY_LINE % [swallowed, to_catch]
  end

  def description(animal)
    if animal == 'spider'
      "\s" + ANIMALS[animal].sub('It', 'that').delete('.')
    end
  end

  def last_line(animal)
    if animals.last == animal
      LAST_LINE_FINAL_VERSE
    else
      LAST_LINE % animals.first
    end
  end

  def animals_until(animal)
    animals.select do |a|
      animals.index(a) <= animals.index(animal)
    end
  end

  def animals
    ANIMALS.keys.freeze
  end
end
