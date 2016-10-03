class BoardPosition < ActiveRecord::Base

  def inside_tic_tac_toe_coordinates
    x_coordinate.between?(1, Board::POSITIONS_PER_DIMENSION) && y_coordinate.between?(1, Board::POSITIONS_PER_DIMENSION)
  end

  def same_coordinates?(a_position)
    x_coordinate == a_position.x_coordinate && y_coordinate == a_position.y_coordinate
  end
end
