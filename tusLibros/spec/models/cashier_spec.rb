require 'rails_helper'

describe Cashier do
  let(:merchant_processor_stub) { instance_spy(MerchantProcessor) }
  let(:cashier) { Cashier.new(merchant_processor_stub) }
  let(:a_user) {create(:user)}
  let(:cart) { Cart.create!(user: a_user) }
  let(:a_credit_card) { create(:credit_card) }
  let(:a_book) { create(:a_book) }
  let(:another_book) { create(:another_book) }

  context 'When checking out with a valid credit card' do
    context 'and an empty cart' do
      it 'should raise an error the cart cannot be empty' do
        expect{ cashier.checkout(cart, a_credit_card) }.to raise_error Cashier.error_message_checking_out_an_empty_cart
      end
    end

    context 'and a cart with a book' do
      before do
        cart.add(a_book, 1)
        cashier.checkout(cart, a_credit_card)
      end

      it 'should bill the credit cart a total amount equal to the price of the book' do
        expect(merchant_processor_stub).to have_received(:charge).with(a_credit_card, a_book.price).once
      end
    end

    context 'and a cart with two different books' do
      let(:total_price_of_books) { a_book.price + another_book.price * 2 }
      before do
        cart.add(a_book, 1)
        cart.add(another_book, 2)
        cashier.checkout(cart, a_credit_card)
      end

      it 'should bill the credit card a total amount equal to the price of each book multiplied by the number of that book' do
        expect(merchant_processor_stub).to have_received(:charge).with(a_credit_card, total_price_of_books).once
      end

      it 'should appear the sale on the sale book' do
        sale = Sale.last
        expect(sale.list_items).to eq({ a_book => 1, another_book => 2 })
        expect(sale.total_price).to eq total_price_of_books
      end

      it 'the client should have one sale registered' do
        expect(a_user.sales.size).to eq 1
      end

      it 'the sale should be the last of this client' do
        sale = a_user.sales.last
        expect(sale.list_items).to eq({ a_book => 1, another_book => 2 })
        expect(sale.total_price).to eq total_price_of_books
      end
    end
  end
end