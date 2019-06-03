class State
  attr_reader :buckets, :goal, :moves

  def initialize(buckets, goal, moves = 1)
    @buckets = buckets
    @goal = goal
    @moves = moves
  end

  def next(buckets)
    self.class.new(buckets, goal, moves + 1)
  end

  def goal?
    !!goal_bucket
  end

  def goal_bucket
    buckets.find { |b| b.content == goal }&.name
  end

  def other_bucket
    goal_bucket && buckets.find { |b| b.content != goal }.content
  end
end
