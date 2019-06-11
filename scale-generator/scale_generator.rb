# frozen_string_literal: true

class Scale
  USE_SHARPS = %w(C G D A E B F# a e b f# c# g# d#)
  SHARP_SCALE = %w(A A# B C C# D D# E F F# G G#)
  FLAT_SCALE = %w(A Bb B C Db D Eb E F Gb G Ab)

  CHROMATIC_STEPS = 'mmmmmmmmmmmm'

  STEPS = {
    'm' => 1,
    'M' => 2,
    'A' => 3
  }

  def initialize(tonic, scale_type, steps = nil)
    @tonic      = tonic
    @scale_type = scale_type
    @steps      = steps || CHROMATIC_STEPS
  end

  def name
    "#{tonic.capitalize} #{scale_type}"
  end

  def pitches
    scale.rotate(offset).values_at(*intervals_from_tonic)
  end

  private

  attr_reader :tonic, :scale_type, :steps

  def scale
    USE_SHARPS.include?(tonic) ? SHARP_SCALE : FLAT_SCALE
  end

  def intervals_from_tonic
    steps.chars.take(steps.size - 1)
      .reduce([0]) do |intervals, step|
        intervals + [intervals.last + STEPS[step]]
      end
  end

  def offset
    scale.index(tonic.capitalize)
  end
end
