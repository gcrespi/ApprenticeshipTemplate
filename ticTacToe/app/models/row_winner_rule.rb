class RowWinnerRule < WinnerRule
  attr_reader :row_number
  def initialize(a_row_number)
    @row_number = a_row_number
  end

  def has_won?(a_player, a_board)
    Board.positions_range.all? do |position|
      a_board.taken_by?(BoardPosition.new(x_coordinate: position, y_coordinate: row_number), a_player)
    end
  end
end