class InProgressBoard < BoardState
  ERROR_MESSAGE_BOARD_STILL_IN_PROGRESS = 'The game is still in progress'
  ERROR_MESSAGE_FOR_ANOTHER_PLAYER_TURN = 'It is not the turn of that player to play'
  ERROR_MESSAGE_FOR_POSITION_OUTSIDE_BOARD = 'Cannot play a position that is outside the board'
  ERROR_MESSAGE_POSITION_ALREADY_TAKEN = 'The position is already taken'

  def finished?
    false
  end

  def winner
    raise ERROR_MESSAGE_BOARD_STILL_IN_PROGRESS
  end

  def apply_move_for(a_position, a_player)
    assert_valid_move(a_position, a_player)
    board.add_move(a_position, a_player)
    change_turn
    advance_game(a_player)
  end

  private
  def next_player_to_play
    self.playing_player.to_sym
  end

  def advance_game(a_player)
    if board.has_won?(a_player)
      board.change_state(WonBoard.create!(winner_player: a_player))
    else
      if board.full
        board.change_state(DrawBoard.create!)
      end
    end
  end

  def change_turn
    aux = self.waiting_player
    self.waiting_player = self.playing_player
    self.playing_player = aux
  end

  def assert_valid_move(a_position, a_player)
    assert_players_turn(a_player)
    assert_position_inside_board(a_position)
    assert_position_not_taken(a_position)
  end

  def assert_position_not_taken(a_position)
    raise ERROR_MESSAGE_POSITION_ALREADY_TAKEN if board.taken?(a_position)
  end

  def assert_position_inside_board(a_position)
    raise ERROR_MESSAGE_FOR_POSITION_OUTSIDE_BOARD unless a_position.inside_tic_tac_toe_coordinates
  end

  def assert_players_turn(a_player)
    raise ERROR_MESSAGE_FOR_ANOTHER_PLAYER_TURN unless next_player_to_play == a_player
  end
end
