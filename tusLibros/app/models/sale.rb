class Sale < ActiveRecord::Base
  belongs_to :user
  belongs_to :credit_card
  has_and_belongs_to_many :books


  def occurrences_of(a_book)
    books.select{ | book | book == a_book }.count
  end
end
