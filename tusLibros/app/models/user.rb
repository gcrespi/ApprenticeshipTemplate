class User < ActiveRecord::Base
  has_many :carts
  has_many :sales
  validates :name, presence: true, uniqueness: true
  has_secure_password
end
