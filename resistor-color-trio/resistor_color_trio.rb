require 'set'

class ResistorColorTrio
  InvalidColor = Class.new(ArgumentError)

  COLORS = %w[black brown red orange yellow
              green blue violet grey white].freeze
  LABEL = "Resistor value: %s".freeze

  def initialize(colors)
    validate_colors!(colors)
    *@digit_colors, @power_color = colors
  end

  def label
    LABEL % format(digits * multiplier)
  end

  private

  attr_reader :digit_colors, :power_color

  def format(value)
    value >= 1000 ? "#{value / 1000} kiloohms" : "#{value} ohms"
  end

  def digits
    digit_colors.map { |c| COLORS.index(c) }.join.to_i
  end

  def multiplier
    10**COLORS.index(power_color)
  end

  def validate_colors!(colors)
    unless colors.to_set.subset?(COLORS.to_set)
      raise InvalidColor
    end
  end
end
