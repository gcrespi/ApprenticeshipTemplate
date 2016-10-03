class Move < ActiveRecord::Base
  belongs_to :board_position
  belongs_to :board

  def in_position?(a_position)
    board_position.same_coordinates?(a_position)
  end
end
