class User < ActiveRecord::Base
  has_many :carts
  has_many :sales
  validates :name, presence: true
  validates :password, presence: true
end
