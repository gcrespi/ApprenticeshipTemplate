class RemoveColumnsUserAndLastOperatedAtToCart < ActiveRecord::Migration
  def change
    remove_column :carts, :user, :last_operated_at
  end
end
