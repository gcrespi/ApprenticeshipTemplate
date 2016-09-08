class AddUserReferenceToSale < ActiveRecord::Migration
  def change
    add_belongs_to :sales, :user
  end
end
