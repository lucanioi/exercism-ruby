# frozen_string_literal: true

class Say
  LIMIT = 999_999_999_999
  FIRST_TWENTY = %w[
    zero one two three four five
    six seven eight nine ten eleven
    twelve thirteen fourteen fifteen
    sixteen seventeen eighteen nineteen
  ]
  TENS = %w[
    zero ten twenty thirty forty
    fifty sixty seventy eighty ninety
  ]
  HUNDRED = 'hundred'
  SHORT_SCALES = {
    1_000_000_000 => 'billion',
    1_000_000 => 'million',
    1_000 => 'thousand',
  }.freeze

  def initialize(number)
    validate!(number)
    @number = number
  end

  def in_english
    say(number)
  end

  private

  attr_reader :number

  def say(num)
    case num
    when 0 then num == number ? zero : ''
    when (1..19) then FIRST_TWENTY[num]
    when (20..99) then tens(num)
    when (100..999) then hundreds(num)
    when (1_000..LIMIT) then large_num(num)
    end
  end

  def large_num(num)
    scale = short_scale(num)
    combine_with(' ') do
      [say(num / scale),
       SHORT_SCALES[scale],
       say(num % scale)]
    end
  end

  def hundreds(num)
    combine_with(' ') do
      [say(num / 100), HUNDRED, say(num % 100)]
     end
  end

  def tens(num)
    combine_with('-') do
      [TENS[num / 10], say(num % 10)]
     end
  end

  def zero
    FIRST_TWENTY.first
  end

  def short_scale(num)
    SHORT_SCALES.keys
     .select { |s| num >= s }.max
  end

  def combine_with(separator, &blk)
    blk.call.reject(&:empty?).join(separator)
  end

  def validate!(num)
    unless (0..LIMIT).include? num
      raise ArgumentError, 'Number must be between 0 ' \
                           'and 1 trillion (exclusive).'
    end
  end
end
