class AddTotalPriceToSale < ActiveRecord::Migration
  def change
    add_column :sales, :total_price, :integer
  end
end
