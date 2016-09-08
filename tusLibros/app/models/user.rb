class User < ActiveRecord::Base
  has_one :cart
  has_many :sales
  validates :name, presence: true
  validates :password, presence: true
end
