module WithWinnerRules

  def has_won?(a_player)
    winner_rules.any?{ | rule | rule.has_won?(a_player, self) }
  end

  private
    def row_winner_rules
      Board.positions_range.map{ | row | RowWinnerRule.new(row) }
    end

    def column_winner_rules
      Board.positions_range.map{ | column | ColumnWinnerRule.new(column) }
    end

    def winner_rules
      [PrincipalDiagonalWinnerRule.new, SecondaryDiagonalWinnerRule.new] + column_winner_rules + row_winner_rules
    end
end