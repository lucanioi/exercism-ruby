require 'set'
require_relative 'bucket'
require_relative 'state'

class TwoBucket < SimpleDelegator
  def initialize(one_size, two_size, goal, fill_first)
    @fill_first = fill_first
    buckets = create_buckets(one_size, two_size).freeze
    initial_state = State.new(buckets, goal)
    __setobj__(measure(initial_state, buckets))
  end

  private

  attr_reader :fill_first

  def measure(initial_state, buckets)
    possible_states = [initial_state]
    while possible_states.any?
      state = possible_states.shift
      mark_seen(state.buckets)
      return state if state.goal?
      possible_states.push(*next_possible_states(state))
    end
    raise 'Could not reach goal'
  end

  def create_buckets(one_size, two_size)
    [
      Bucket.new('one', one_size),
      Bucket.new('two', two_size)
    ].map { |b| fill_first?(b) ? b.fill : b }
  end

  def next_possible_states(state)
    next_moves(*state.buckets)
      .reject(&method(:seen?))
      .reject(&method(:invalid?))
      .map { |bs| state.next(bs) }
  end

  def next_moves(one, two)
    [
      [one.fill, two],
      [one.empty, two],
      [one, two.empty],
      [one, two.fill],
      Bucket.pour(from: one, to: two),
      Bucket.pour(from: two, to: one).reverse
    ]
  end

  def invalid?(buckets)
    first, second = buckets.sort_by { |b| fill_first?(b) ? 0 : 1 }
    first.empty? && second.full?
  end

  def mark_seen(buckets)
    seen << buckets.map(&:content)
  end

  def seen?(buckets)
    seen.include?(buckets.map(&:content))
  end

  def seen
    @seen ||= Set.new
  end

  def fill_first?(bucket)
    bucket.name == fill_first
  end
end
