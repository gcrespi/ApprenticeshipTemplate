require 'uri'
require 'net/http'

class MerchantProcessor
  def charge(a_credit_card, a_total_amount)
    response = request_to_merchant_processor(a_credit_card, a_total_amount)
    unless successful_debit(response)
      raise self.class.error_message_for_bad_request if response.code != '200'
      raise response_error_description(response)
    end
  end

  def self.error_message_for_bad_request
    'Could not debit from credit card'
  end

  def response_error_description(response)
    response.body.split('|').second
  end

  def response_transaction_code(response)
    response.body.split('|').first
  end

  def successful_debit(response)
    response.code == '200' && response_transaction_code(response) == '0'
  end

  def request_to_merchant_processor(a_credit_card, a_total_amount)
    params = params_for_merchant_request(a_credit_card, a_total_amount)
    uri = URI.parse(Rails.configuration.merchant_processor_url)
    Net::HTTP.post_form(uri, params)
  end

  def params_for_merchant_request(a_credit_card, a_total_amount)
    {
      'creditCardNumber' => a_credit_card.number,
      'creditCardExpiration' => a_credit_card.expiration,
      'creditCardOwner' => a_credit_card.owner,
      'transactionAmount' => a_total_amount.to_s
    }
  end
end