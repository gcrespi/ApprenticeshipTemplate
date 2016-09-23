class Cart < ActiveRecord::Base
  has_and_belongs_to_many :books

  def self.error_message_for_non_positive_amount_of_books
    'Cannot add an amount of books less or equals than 0'
  end

  def assert_positive_amount(an_amount)
    raise self.class.error_message_for_non_positive_amount_of_books unless an_amount > 0
  end

  def empty?
    books.empty?
  end

  def amount_of_books
    books.size
  end

  def add(a_book, an_amount)
    assert_positive_amount(an_amount)
    an_amount.times { books.push(a_book) }
  end

  def occurrences_of(a_book)
    books.select{ | book | book == a_book }.count
  end

  def content
    books
  end

  def total_amount
    books.map{ | book | book.price }.reduce(0, :+)
  end
end
