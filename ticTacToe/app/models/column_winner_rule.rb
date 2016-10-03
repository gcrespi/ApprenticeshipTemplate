class ColumnWinnerRule < WinnerRule
  attr_reader :column_number

  def initialize(a_column_number)
    @column_number = a_column_number
  end

  def has_won?(a_player, a_board)
    Board.positions_range.all? do |position|
      a_board.taken_by?(BoardPosition.new(x_coordinate: column_number, y_coordinate: position), a_player)
    end
  end
end
