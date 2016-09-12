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

      it 'the ' do
        previous_amount_of_carts = a_user.carts.size
        post :create
        a_user.reload
        expect(a_user.carts.size).to eq(previous_amount_of_carts + 1)
      end
    end
  end
end
