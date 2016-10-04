class Board < ActiveRecord::Base
  include WithWinnerRules

  POSITIONS_PER_DIMENSION = 3
  DIMENSIONS = 2

  has_many :moves
  has_one :board_state

  delegate :finished?, :winner, :apply_move_for, to: :board_state

  def self.create_in_progress_board!(attrs = {})
    self.create!(attrs.merge(board_state: InProgressBoard.create!(playing_player: :player_x, waiting_player: :player_o)))
  end

  def self.positions_range
    (1..POSITIONS_PER_DIMENSION)
  end

  def taken?(a_position)
    moves.any? { |move| move.in_position?(a_position) }
  end

  def taken_by?(a_position, a_player)
    moves.any? { |move| move.in_position?(a_position) && move.player.to_sym == a_player }
  end

  def add_move(a_position, a_player)
    moves.create!(board_position: a_position, player: a_player)
  end

  def change_state(new_state)
    self.board_state = new_state
  end

  def full
    moves.size == POSITIONS_PER_DIMENSION**DIMENSIONS
  end
end
