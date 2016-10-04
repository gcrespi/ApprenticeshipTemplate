class WonBoard < BoardState
  def finished?
    true
  end

  def winner
    self.winner_player.to_sym
  end

  def apply_move_for(a_position, a_player)
    raise ERROR_MESSAGE_BOARD_ALREADY_FINISHED
  end
end
