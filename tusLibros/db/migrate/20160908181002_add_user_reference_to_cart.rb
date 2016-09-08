class AddUserReferenceToCart < ActiveRecord::Migration
  def change
    add_belongs_to :carts, :user
  end
end
