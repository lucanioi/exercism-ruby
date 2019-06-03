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
    @string = string
  end

  def convert
    validate
    parse_input
    convert_to_chars
  end

  private

  attr_reader :string, :ocrs

  def validate
    unless valid_height? && valid_width?
      raise ArgumentError, 'Malformed OCR string'
    end
  end

  def parse_input
    @ocrs = string.split("\n").each_slice(4).map do |lines|
      reconstruct_ocr(lines)
    end
  end

  def convert_to_chars
    return if ocrs.empty?

    ocrs.map do |line|
      line.map { |ocr| identify(ocr) }.join
    end.join(',')
  end

  def valid_height?
    string.split("\n").size.modulo(OCR_HEIGHT).zero?
  end

  def valid_width?
    string.split("\n").all? { |col| col.size.modulo(OCR_WIDTH).zero? }
  end

  def reconstruct_ocr(lines)
    ocrs_hash = Hash.new { |h, k| h[k] = [] }

    lines.each_with_object(ocrs_hash) do |line, ocrs|
      line.scan(/.{#{OCR_WIDTH}}/).each_with_index do |segment, i|
        ocrs[i] << segment
      end
    end.values.map { |ocr| ocr.join("\n") }
  end

  def identify(string)
    OCR.fetch(string, '?')
  end
end

module BookKeeping
  VERSION = 1
end