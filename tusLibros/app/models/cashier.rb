class Cashier
  def initialize(a_merchant_processor)
    @merchant_processor = a_merchant_processor
  end

  def self.error_message_checking_out_an_empty_cart
    'Cannot checkout an empty cart'
  end

  def checkout(a_cart, a_credit_card)
    assert_cart_not_empty(a_cart)
    @merchant_processor.charge(a_credit_card, a_cart.total_amount)
    register_sale(a_cart, a_credit_card)
    a_cart.destroy
  end

  def register_sale(a_cart, a_credit_card)
    Sale.create!(credit_card: a_credit_card, books: a_cart.content, total_price: a_cart.total_amount, user: a_cart.user)
  end

  def assert_cart_not_empty(a_cart)
    raise self.class.error_message_checking_out_an_empty_cart if a_cart.empty?
  end
end