module Luhn
  extend self

  def valid?(input)
    Validator.new(input).valid?
  end

  class Validator
    MINIMUM_LENGTH = 2
    VALID_CHARS = /\A\d+\z/

    def initialize(input)
      @input = input.to_s.gsub(/\s/, '')
    end

    def valid?
      valid_length? && valid_chars? && valid_luhn?
    end

    private

    attr_reader :input

    def valid_length?
      input.size >= MINIMUM_LENGTH
    end

    def valid_chars?
      !!(input =~ VALID_CHARS)
    end

    def valid_luhn?
      input.chars.reverse.map.with_index do |digit, index|
        index.even? ? digit.to_i : double(digit.to_i)
      end.sum.modulo(10).zero?
    end

    def double(number)
      doubled = number * 2
      doubled > 9 ? doubled - 9 : doubled
    end
  end
end

module BookKeeping
  VERSION = 1
end