class DrawBoard < BoardState
  def finished?
    true
  end

  def winner
    :draw
  end

  def apply_move_for(a_position, a_player)
    raise ERROR_MESSAGE_BOARD_ALREADY_FINISHED
  end
end
