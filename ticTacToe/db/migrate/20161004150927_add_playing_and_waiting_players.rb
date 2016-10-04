class AddPlayingAndWaitingPlayers < ActiveRecord::Migration
  def change
    add_column :board_states, :playing_player, :string
    add_column :board_states, :waiting_player, :string
  end
end
