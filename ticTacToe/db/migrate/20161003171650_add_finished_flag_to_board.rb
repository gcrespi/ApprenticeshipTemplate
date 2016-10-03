class AddFinishedFlagToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :finished, :boolean, default: false
  end
end
