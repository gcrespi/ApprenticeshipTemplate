require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'When creating a credit card' do
    context 'and the credit card number is too short' do
      let(:credit_card){ build(:credit_card, number: '431444153') }
      it 'should raise an error of invalid card' do
        expect(credit_card).not_to be_valid
        expect(credit_card.errors[:number]).to be_include CreditCard.error_message_for_invalid_credit_card
      end
    end

    context 'and the credit card number has letters' do
      let(:credit_card){ build(:credit_card, number: '471237ASD1444153') }
      it 'should raise an error of invalid card' do
        expect(credit_card).not_to be_valid
        expect(credit_card.errors[:number]).to be_include CreditCard.error_message_for_invalid_credit_card
      end
    end

    context 'and the expiration date has already past' do
      let(:credit_card) { build(:credit_card, expiration_date: Date.new(2000, 12))}
      it 'should raise an error of expired credit card' do
        expect(credit_card).not_to be_valid
        expect(credit_card.errors[:expiration_date]).to be_include CreditCard.error_message_for_expired_credit_card
      end
    end

    context 'and the credit card owner is too long' do
      let(:credit_card) { build(:credit_card, owner: 'Esto Es Un Nombre Demasiado Largo Para Una Tarjeta De Credito') }
      it 'should raise an error credit card owner invalid' do
        expect(credit_card).not_to be_valid
        expect(credit_card.errors[:owner]).to be_include CreditCard.error_message_for_credit_card_owner_invalid
      end
    end
  end
end
