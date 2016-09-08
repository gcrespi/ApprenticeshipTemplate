class Cashier
  def initialize(a_merchant_processor)
    @merchant_processor = a_merchant_processor
  end

  def self.error_message_checking_out_an_empty_cart
    'Cannot checkout an empty cart'
  end

  def checkout(a_cart, a_credit_card)
    raise self.class.error_message_checking_out_an_empty_cart if a_cart.empty?
    @merchant_processor.charge(a_credit_card, a_cart.total_amount)
  end
end