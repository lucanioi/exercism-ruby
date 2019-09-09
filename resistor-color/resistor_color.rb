module ResistorColor
  COLORS = %w[black brown red orange yellow
              green blue violet grey white]

  module_function

  def color_code(color)
    COLORS.index(color)
  end
end

