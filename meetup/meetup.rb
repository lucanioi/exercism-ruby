require 'date'

class Meetup
  DESCRIPTORS = { first: 0, second: 1, third: 2, fourth: 3, last: -1 }

  def initialize(month, year)
    @month = month
    @year  = year
  end

  def day(weekday, descriptor)
    all_days_in_month
      .select { |day| day.send("#{weekday}?") }
      .then { |days| find_exact_date(days, descriptor) }
  end

  private

  attr_reader :month, :year

  def all_days_in_month
    Date.new(year, month, 1)..Date.new(year, month, -1)
  end

  def find_exact_date(days, descriptor)
    case descriptor
    when *DESCRIPTORS.keys then days[DESCRIPTORS[descriptor]]
    when :teenth then days.find { |day| (13..19).include? day.day }
    end
  end
end
