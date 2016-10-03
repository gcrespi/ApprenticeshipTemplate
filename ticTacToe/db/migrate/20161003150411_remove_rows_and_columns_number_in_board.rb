class RemoveRowsAndColumnsNumberInBoard < ActiveRecord::Migration
  def change
    remove_column :boards, :rows
    remove_column :boards, :columns
  end
end
