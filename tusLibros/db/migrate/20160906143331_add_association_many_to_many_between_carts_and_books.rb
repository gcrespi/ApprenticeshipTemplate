class AddAssociationManyToManyBetweenCartsAndBooks < ActiveRecord::Migration
  def change
    create_table :books_carts, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :cart, index: true
    end
  end
end
