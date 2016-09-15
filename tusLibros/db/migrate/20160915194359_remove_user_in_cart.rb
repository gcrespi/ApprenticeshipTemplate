class RemoveUserInCart < ActiveRecord::Migration
  def change
    remove_column :carts, :user
  end
end
