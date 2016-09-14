class Cart < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :books
  validates :user, presence: true
  before_create :update_last_operated

  def update_last_operated
    self.last_operated_at = Time.now
  end

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

  def list_cart
    books.group_by{ | a_book | a_book }.map{ | a_book, book_list | [a_book.isbn, book_list.size] }.to_h
  end

  def content
    books
  end

  def total_amount
    books.map{ | book | book.price }.reduce(0, :+)
  end

  def active?
    (Time.now - last_operated_at).seconds < 30.minutes
  end
end
