class Board
  def initialize(board)
    @rows = board.map(&:split)
  end

  def winner
    case
    when connect?('O', rows) then 'O'
    when connect?('X', rows.transpose) then 'X'
    else ''
    end
  end

  private

  attr_reader :rows, :seen

  def connect?(player, rows)
    Connect.new(player, rows).connect?
  end
end

class Connect
  Field = Struct.new(:stone, :position)

  def initialize(player, rows)
    @player = player
    @rows   = create_fields(rows)
    @paths  = starting_points
    @seen   = []
    traverse!
  end

  def connect?
    paths.any?(&method(:reached_end?))
  end

  private

  attr_reader :player, :rows, :paths, :seen

  def traverse!
    while next_paths(paths).any?
      @seen += paths
      @paths = next_paths(paths)
    end
  end

  def starting_points
    rows.first.select(&method(:own?))
  end

  def next_paths(paths)
    paths
      .flat_map(&method(:surrounding_fields))
      .select(&method(:connectable?))
  end

  def connectable?(field)
    own?(field) && !seen.include?(field)
  end

  def own?(field)
    field.stone == player
  end

  def surrounding_fields(field)
    neighbor_steps.map do |step|
      fetch_field add(field.position, step)
    end.compact
  end

  def neighbor_steps
    [-1, 0, 1].permutation(2).uniq
  end

  def fetch_field((row_i, col_i))
    rows[row_i]&.dig(col_i) if [row_i, col_i].min >= 0
  end

  def add(pos1, pos2)
    pos1.zip(pos2).map(&:sum)
  end

  def reached_end?(field)
    field.position.first == rows.size - 1
  end

  def create_fields(rows)
    rows.map.with_index do |row, row_i|
      row.map.with_index { |stone, col_i| Field.new(stone, [row_i, col_i]) }
    end
  end
end

