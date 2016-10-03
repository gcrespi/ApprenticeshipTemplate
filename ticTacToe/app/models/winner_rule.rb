class WinnerRule
  SUBCLASS_RESPONSIBILITY = 'SUBCLASS RESPONSIBILITY'
  def self.row_winner_rules
    Board.positions_range.map{ | row | RowWinnerRule.new(row) }
  end

  def self.column_winner_rules
    Board.positions_range.map{ | column | ColumnWinnerRule.new(column) }
  end

  def self.winner_rules
    [PrincipalDiagonalWinnerRule.new, SecondaryDiagonalRule.new] + self.column_winner_rules + self.row_winner_rules
  end

  def self.has_won?(a_player, a_board)
    self.winner_rules.any?{ | rule | rule.has_won?(a_player, a_board) }
  end

  def has_won?(a_player, a_board)
    raise SUBCLASS_RESPONSIBILITY
  end
end