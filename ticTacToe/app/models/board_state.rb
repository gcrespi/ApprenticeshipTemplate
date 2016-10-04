class BoardState < ActiveRecord::Base
  ERROR_MESSAGE_BOARD_ALREADY_FINISHED = 'Game has already finished'

  belongs_to :board

  def finished?
    raise SubclassResponsibility
  end

  def winner
    raise SubclassResponsibility
  end

  def apply_move_for(a_position, a_player)
    raise SubclassResponsibility
  end
end
