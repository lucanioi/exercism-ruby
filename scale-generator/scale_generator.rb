class Scale
  USE_SHARPS = %w(C G D A E B F# a e b f# c# g# d#).freeze
  SCALE_WITH_SHARPS = %w(A A# B C C# D D# E F F# G G#).freeze
  SCALE_WITH_FLATS = %w(A Bb B C Db D Eb E F Gb G Ab).freeze

  CHROMATIC_INTERVALS = 'mmmmmmmmmmmm'.freeze

  INTERVALS = {
    'm' => 1,
    'M' => 2,
    'A' => 3
  }.freeze

  def initialize(tonic, scale_type, intervals = nil)
    @tonic      = tonic
    @scale_type = scale_type
    @intervals  = intervals || CHROMATIC_INTERVALS
  end

  def name
    "#{tonic.capitalize} #{scale_type}"
  end

  def pitches
    scale.rotate(offset).values_at(*normalize_intervals)
  end

  private

  attr_reader :tonic, :scale_type, :intervals

  def scale
    USE_SHARPS.include?(tonic) ? SCALE_WITH_SHARPS : SCALE_WITH_FLATS
  end

  def normalize_intervals
    intervals.chars.take(intervals.size - 1).reduce([0]) do |normalized_intervals, interval|
      normalized_intervals << normalized_intervals.last + INTERVALS[interval]
    end
  end

  def offset
    scale.index(tonic.capitalize)
  end
end
