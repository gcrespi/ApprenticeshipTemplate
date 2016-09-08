class Sale < ActiveRecord::Base
  belongs_to :user
  belongs_to :credit_card
  has_and_belongs_to_many :books

  def list_items
    books.group_by{ | a_book | a_book }.map{ | a_book, book_list | [a_book, book_list.size] }.to_h
  end
end
