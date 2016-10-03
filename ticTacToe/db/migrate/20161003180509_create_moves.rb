class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.belongs_to :board
      t.string :player
      t.belongs_to :board_position
      t.timestamps null: false
    end
  end
end
