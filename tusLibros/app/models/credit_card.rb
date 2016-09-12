class CreditCard < ActiveRecord::Base

  def self.error_message_for_credit_card_owner_invalid
    'The name of the credit card owner cannot be longer than 30 characters'
  end

  def self.error_message_for_invalid_credit_card
    'The credit card is invalid'
  end

  def self.error_message_for_expired_credit_card
    'The credit card is expired'
  end

  validates :owner, length: { maximum: 29 , message: CreditCard.error_message_for_credit_card_owner_invalid}
  validates_format_of :number, with: /[0-9]{16}/, message: CreditCard.error_message_for_invalid_credit_card
  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    errors.add(:expiration_date, CreditCard.error_message_for_expired_credit_card) if expiration_date <= Date.today
  end

  def expiration
    "#{expiration_date.month}#{expiration_date.year}"
  end

end
