require 'rails_helper'

describe MerchantProcessor do
  let(:a_merchant_processor) { MerchantProcessor.new }
  context 'When requesting to charge with a credit card' do
    let(:a_credit_card) { create(:credit_card) }
    context 'and a total amount of 500' do
      let(:a_price) { 500 }
      let(:params) {
        {
            'creditCardNumber' => a_credit_card.number,
            'creditCardExpiration' => a_credit_card.expiration,
            'creditCardOwner' => a_credit_card.owner,
            'transactionAmount' => a_price.to_s
        }
      }

      context 'and the server can process the request successfully' do
        it 'the request should success' do
          stub_request(:post, Rails.configuration.merchant_processor_url).
              with(body: params).
              to_return(status: 200, body: '0|OK')
          expect{ a_merchant_processor.charge(a_credit_card, a_price) }.not_to raise_error
        end
      end

      context 'and the merchant processor responses bad request' do
        it 'should raise an error telling so' do
          stub_request(:post, Rails.configuration.merchant_processor_url).
              with(body: params).
              to_return(status: 400, body: '0|OK')
          expect{ a_merchant_processor.charge(a_credit_card, a_price) }.to raise_error MerchantProcessor.error_message_for_bad_request
        end
      end

      context 'and the merchant processor responses that the transaction could not be made' do
        let(:a_reason) { 'Error reason goes here' }
        it 'should raise an error telling the reason' do
          stub_request(:post, Rails.configuration.merchant_processor_url).
              with(body: params).
              to_return(status: 200, body: "1|#{a_reason}")
          expect{ a_merchant_processor.charge(a_credit_card, a_price) }.to raise_error a_reason
        end
      end
    end
  end
end