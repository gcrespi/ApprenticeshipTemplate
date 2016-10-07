class BoardsController < ApplicationController
  def create
    board = Board.create_in_progress_board!
    render json: board
  end

  def make_move
    position = BoardPosition.new(x_coordinate: params.require(:x_coordinate), y_coordinate: params.require(:y_coordinate))
    player = params.require(:player).to_sym
    board = Board.find(params.require(:board_id))
    board.apply_move_for(position, player)

    render json: board
  end
end
