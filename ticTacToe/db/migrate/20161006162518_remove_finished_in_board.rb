class RemoveFinishedInBoard < ActiveRecord::Migration
  def change
    remove_column :boards, :finished
  end
end
