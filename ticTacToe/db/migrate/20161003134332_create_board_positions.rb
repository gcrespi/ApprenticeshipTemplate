class CreateBoardPositions < ActiveRecord::Migration
  def change
    create_table :board_positions do |t|
      t.integer :x_coordinate
      t.integer :y_coordinate

      t.timestamps null: false
    end
  end
end
