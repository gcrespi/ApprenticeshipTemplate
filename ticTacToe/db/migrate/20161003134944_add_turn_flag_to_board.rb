class AddTurnFlagToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :player_x_turn, :boolean, default: true
  end
end
