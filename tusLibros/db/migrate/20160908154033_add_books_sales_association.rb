class AddBooksSalesAssociation < ActiveRecord::Migration
  def change
    create_table :books_sales do |t|
      t.belongs_to :book, index: true
      t.belongs_to :sale, index: true
    end
  end
end
