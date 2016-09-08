class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.belongs_to :credit_card, index: true
      t.timestamps null: false
    end
  end
end
