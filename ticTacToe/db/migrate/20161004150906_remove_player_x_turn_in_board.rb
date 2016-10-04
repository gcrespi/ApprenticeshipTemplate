class RemovePlayerXTurnInBoard < ActiveRecord::Migration
  def change
    remove_column :boards, :player_x_turn
  end
end
