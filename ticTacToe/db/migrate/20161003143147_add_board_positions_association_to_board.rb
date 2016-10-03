class AddBoardPositionsAssociationToBoard < ActiveRecord::Migration
  def change
    add_belongs_to :board_positions, :board
  end
end
