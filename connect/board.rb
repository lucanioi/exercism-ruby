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
