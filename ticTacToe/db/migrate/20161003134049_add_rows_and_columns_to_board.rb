class AddRowsAndColumnsToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :rows, :integer
    add_column :boards, :columns, :integer
  end
end
