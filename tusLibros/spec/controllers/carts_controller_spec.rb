require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  context 'When requesting to add 2 books to a cart' do
    let(:a_book) { create(:a_book) }
    let(:a_cart) { create(:cart) }
    before do
      post :add_books, {cart_id: a_cart.id, isbn: a_book.isbn, quantity: 2}
    end

    it 'the cart should have that book twice' do
      expect(a_cart.occurrences_of(a_book)).to eq 2
    end
  end

  context 'When requesting to create a cart' do
    context 'and a user is logged' do
      let(:a_user) { create(:user) }
      before do
        session[:user_id] = a_user.id
      end

      it 'the user should have one more cart' do
        previous_amount_of_carts = a_user.carts.size
        post :create
        a_user.reload
        expect(a_user.carts.size).to eq(previous_amount_of_carts + 1)
      end
    end
  end

  context 'When requesting to checkout a cart' do
    context 'and the cart is not empty' do
      let(:a_cart) { create(:cart) }
      let(:a_price) { 30 }
      let(:a_book) { create(:a_book, price: a_price) }

      before do
        a_cart.add(a_book, 1)
      end

      context 'a user is logged and is the owner of the cart' do
        let(:a_credit_card) { build(:credit_card) }
        let(:params) { {
            'creditCardNumber' => a_credit_card.number,
            'creditCardExpiration' => a_credit_card.expiration,
            'creditCardOwner' => a_credit_card.owner,
            'transactionAmount' => a_price.to_s
          }
        }

        before do
          session[:user_id] = a_cart.user.id
          stub_request(:post, Rails.configuration.merchant_processor_url)
              .with(:body => params)
              .to_return(:status => 200, :body => '0|OK', :headers => {})
          post :checkout, {
              cartId: a_cart.id,
              ccn: a_credit_card.number,
              cco: a_credit_card.owner,
              cced: a_credit_card.expiration_date
          }
        end

        it 'the cart should be no more' do
          expect(Cart.find_by(id: a_cart.id)).to be_nil
        end
      end
    end
  end
end
