class Board < ActiveRecord::Base
  ERROR_MESSAGE_FOR_ANOTHER_PLAYER_TURN = 'It is not the turn of that player to play'
  ERROR_MESSAGE_FOR_POSITION_OUTSIDE_BOARD = 'Cannot play a position that is outside the board'
  ERROR_MESSAGE_POSITION_ALREADY_TAKEN = 'The position is already taken'
  ERROR_MESSAGE_BOARD_ALREADY_FINISHED = 'Game has already finished'
  POSITIONS_PER_DIMENSION = 3
  DIMENSIONS = 2
  has_many :moves
  has_one :board_state

  def self.create_in_progress_board!(attrs)
    self.create!(attrs.merge(board_state: InProgressBoard.create!))
  end

  def self.positions_range
    (1..POSITIONS_PER_DIMENSION)
  end

  def finished?
    board_state.finished?
  end

  def winner
    board_state.winner
  end

  def assert_valid_move(a_position, a_player)
    assert_players_turn(a_player)
    assert_position_inside_board(a_position)
    assert_position_not_taken(a_position)
    assert_not_finished_board
  end

  def choose_position_for(a_position, a_player)
    assert_valid_move(a_position, a_player)
    moves.create!(board_position: a_position, player: a_player)
    self.advance_game(a_player)
  end

  def advance_game(a_player)
    self.player_x_turn = !self.player_x_turn
    if WinnerRule.has_won?(a_player, self)
      board_state = WonBoard.create!(a_player)
    else
      if moves.size == POSITIONS_PER_DIMENSION**DIMENSIONS
        board_state = DrawBoard.create!
      end
    end
  end

  def taken?(a_position)
    moves.any? { |move| move.in_position?(a_position) }
  end

  def taken_by?(a_position, a_player)
    moves.any? do |move|
      move.in_position?(a_position) && move.player.to_sym == a_player
    end
  end

  def assert_not_finished_board
    raise ERROR_MESSAGE_BOARD_ALREADY_FINISHED if self.finished?
  end

  def assert_position_not_taken(a_position)
    raise ERROR_MESSAGE_POSITION_ALREADY_TAKEN if self.taken?(a_position)
  end

  def assert_position_inside_board(a_position)
    raise ERROR_MESSAGE_FOR_POSITION_OUTSIDE_BOARD unless a_position.inside_tic_tac_toe_coordinates
  end

  def assert_players_turn(a_player)
    raise ERROR_MESSAGE_FOR_ANOTHER_PLAYER_TURN unless next_player_to_play == a_player
  end

  def next_player_to_play
    player_x_turn ? :player_x : :player_o
  end
end
