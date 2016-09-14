class AddLastTimeOperatedToCart < ActiveRecord::Migration
  def change
    add_column :carts, :last_operated_at, :datetime
  end
end
