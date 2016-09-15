class User < ActiveRecord::Base
  has_many :cart_sessions
  has_many :carts, through: :cart_sessions
  has_many :sales
  validates :name, presence: true, uniqueness: true
  has_secure_password
end
