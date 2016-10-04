class SecondaryDiagonalRule < WinnerRule
  def has_won?(a_player, a_board)
    Board.positions_range.all? do | position |
      a_board.taken_by?(BoardPosition.new(x_coordinate: column_for(position), y_coordinate: position), a_player)
    end
  end

  def column_for(a_row)
    (1 + Board::POSITIONS_PER_DIMENSION) - a_row
  end
end