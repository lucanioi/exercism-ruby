module ETL
  module_function

  def transform(old)
    old.reduce({}) do |new_format, (score, letters)|
      letters.reduce(new_format) do |nf, letter|
        nf.merge({letter.downcase => score})
      end
    end
  end
end
