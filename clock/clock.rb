class Clock
  MINUTES_MAX = 60
  HOURS_MAX   = 24

  def initialize(hour: 0, minute: 0)
    set_time(hour, minute)
  end

  def to_s
    '%02d:%02d' % [hour, minute]
  end

  def +(other)
    self.class.new(
      hour: hour + other.hour,
      minute: minute + other.minute
    )
  end

  def -(other)
    self.class.new(
      hour: hour - other.hour,
      minute: minute - other.minute
    )
  end

  def ==(other)
    hour == other.hour && minute == other.minute
  end

  protected

  attr_reader :hour, :minute

  private

  def set_time(hour, minute)
    @hour   = (hour + minute / MINUTES_MAX) % HOURS_MAX
    @minute = minute % MINUTES_MAX
  end
end
