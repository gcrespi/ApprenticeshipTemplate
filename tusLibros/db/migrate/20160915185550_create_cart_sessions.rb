class CreateCartSessions < ActiveRecord::Migration
  def change
    create_table :cart_sessions do |t|
      t.belongs_to :user
      t.belongs_to :cart

      t.timestamps null: false
    end
  end
end
