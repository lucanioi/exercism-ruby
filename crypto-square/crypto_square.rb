class Crypto
  def initialize(text)
    @text = text
  end

  def ciphertext
    return '' if text.empty?

    rectangle = create_rectangle
    rectangle.encrypt
  end

  private

  attr_reader :text, :normalized_text

  def normalize_text
    text.gsub(/\W/, '').downcase
  end

  def create_rectangle
    CryptoRectangle.new(normalize_text)
  end
end

class CryptoRectangle
  def initialize(text)
    @text = text
    @rectangle = build_rectangle
  end

  def encrypt
    rectangle.transpose.map(&:join).join("\s")
  end

  private

  attr_reader :rectangle, :text

  def build_rectangle
    text.chars.each_slice(width).to_a.tap do |rect|
      fill_last_row(rect)
    end
  end

  def width
    @width ||= Math.sqrt(text.size).ceil
  end

  def fill_last_row(rectangle)
    last_row = rectangle.last
    last_row << "\s" until last_row.size == width
  end
end
