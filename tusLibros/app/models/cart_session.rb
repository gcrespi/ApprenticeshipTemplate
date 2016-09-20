class CartSession < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user

  validates :user_id, presence: true
  validates :cart_id, presence: true
  before_create :update_last_operated


  def self.error_message_for_inaccessible_cart
    'You do not have access to the cart'
  end

  def self.create_with_cart!(attrs)
    cart = Cart.create!
    CartSession.create!(attrs.merge(cart: cart))
  end

  def update_last_operated
    self.last_operated_at = Time.now
  end

  def empty?
    assert_active_session
    cart.empty?
  end

  def amount_of_books
    assert_active_session
    cart.size
  end

  def add(a_book, an_amount)
    assert_active_session
    cart.add(a_book, an_amount)
  end

  def occurrences_of(a_book)
    assert_active_session
    cart.occurrences_of(a_book)
  end

  def list_cart
    assert_active_session
    cart.list_cart
  end

  def content
    assert_active_session
    cart.content
  end

  def total_amount
    assert_active_session
    cart.total_amount
  end

  def assert_active_session
    raise ExpiredCartException, self.class.error_message_for_expired_cart unless active?
  end

  def self.error_message_for_expired_cart
    'The cart has already expired'
  end

  def active?
    (Time.now - last_operated_at).seconds < 30.minutes
  end

  def destroy
    cart.destroy
    super
  end
end
