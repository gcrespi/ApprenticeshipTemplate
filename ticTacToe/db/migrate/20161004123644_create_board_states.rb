class CreateBoardStates < ActiveRecord::Migration
  def change
    create_table :board_states do |t|
      t.string :winner_player
      t.string :type
      t.belongs_to :board
      t.timestamps null: false
    end
  end
end
