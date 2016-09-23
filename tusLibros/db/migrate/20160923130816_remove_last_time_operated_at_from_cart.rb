class RemoveLastTimeOperatedAtFromCart < ActiveRecord::Migration
  def change
    remove_column :carts, :last_operated_at
  end
end
