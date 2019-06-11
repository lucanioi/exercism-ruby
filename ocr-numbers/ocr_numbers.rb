class OcrNumbers
  OCR = {
    " _ \n| |\n|_|\n   " => '0',
    "   \n  |\n  |\n   " => '1',
    " _ \n _|\n|_ \n   " => '2',
    " _ \n _|\n _|\n   " => '3',
    "   \n|_|\n  |\n   " => '4',
    " _ \n|_ \n _|\n   " => '5',
    " _ \n|_ \n|_|\n   " => '6',
    " _ \n  |\n  |\n   " => '7',
    " _ \n|_|\n|_|\n   " => '8',
    " _ \n|_|\n _|\n   " => '9'
  }.freeze

  OCR_WIDTH  = 3
  OCR_HEIGHT = 4

  class << self
    def convert(ocr_string)
      new(ocr_string).convert
    end

    private :new
  end

  def initialize(string)
    validate!(string)
    @string = string
    @ocrs = parse(string)
  end

  def convert
    ocrs.map do |line|
      line.map(&method(:identify)).join
    end.join(',')
  end

  private

  attr_reader :string, :ocrs

  def reconstruct_ocr(lines)
    ocrs = Hash.new { |h, k| h[k] = [] }

    lines.each_with_object(ocrs) do |line, ocrs|
      line.scan(/.{#{OCR_WIDTH}}/).each_with_index do |segment, i|
        ocrs[i] << segment
      end
    end.values.map { |ocr| ocr.join("\n") }
  end

  def identify(string)
    OCR.fetch(string, '?')
  end

  def validate!(string)
    unless valid_height?(string) && valid_width?(string)
      raise ArgumentError, 'Malformed OCR string'
    end
  end

  def valid_height?(string)
    string.split("\n").size.modulo(OCR_HEIGHT).zero?
  end

  def valid_width?(string)
    string.split("\n").all? { |col| col.size.modulo(OCR_WIDTH).zero? }
  end

  def parse(string)
    string.split("\n").each_slice(4).map do |lines|
      reconstruct_ocr(lines)
    end
  end
end
