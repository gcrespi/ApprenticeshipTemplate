require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:a_book) { Book.create!(:isbn => '9788427811362', :price => 20) }
  let(:a_cart) { Cart.create! }

  context 'When requesting to add 2 books to a cart' do
    before do
      post :add_books, {cart_id: a_cart.id, isbn: a_book.isbn, quantity: 2}
    end

    it 'the cart should have that book twice' do
      expect(a_cart.occurrences_of(a_book)).to eq 2
    end
  end
end