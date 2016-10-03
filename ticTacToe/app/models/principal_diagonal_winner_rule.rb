class PrincipalDiagonalWinnerRule < WinnerRule
  def has_won?(a_player, a_board)
    Board.positions_range.all? do | position |
      a_board.taken_by?(BoardPosition.new(x_coordinate: position, y_coordinate: position), a_player)
    end
  end
end