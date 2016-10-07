class BoardsController < ApplicationController
  def create
    board = Board.create_in_progress_board!
    render json: board
  end

  def make_move
    position = Position.new(params.require(:x_coordinate), params.require(:y_coordinate))
    player = params.require(:player)
    board = Board.find(params.require(:board_id))
    board.apply_move_for(position, player)
  end
end
