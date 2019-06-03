module ResistorColorDuo
  InvalidColor = Class.new(StandardError)

  COLORS = %w[black brown red orange yellow green blue violet grey white].freeze

  module_function

  def value(colors)
    colors.map do |color|
      COLORS.index(color) || raise(InvalidColor, "'#{color}'")
    end.join.to_i
  end
end
