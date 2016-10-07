class Move < ActiveRecord::Base
  ERROR_MESSAGE_FOR_POSITION_OUTSIDE_BOARD = 'Cannot play a position that is outside the board'
  ERROR_MESSAGE_POSITION_ALREADY_TAKEN = 'The position is already taken'

  belongs_to :board_position
  belongs_to :board

  validate :assert_position_not_taken, :assert_position_inside_board

  def in_position?(a_position)
    board_position.same_coordinates?(a_position)
  end

  def assert_position_not_taken
    errors.add(:board_position, ERROR_MESSAGE_POSITION_ALREADY_TAKEN) if board.taken?(board_position)
  end

  def assert_position_inside_board
    errors.add(:board_position, ERROR_MESSAGE_FOR_POSITION_OUTSIDE_BOARD) unless board_position.inside_tic_tac_toe_coordinates
  end
end
