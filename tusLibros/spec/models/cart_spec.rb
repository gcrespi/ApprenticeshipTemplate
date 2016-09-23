require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:a_book) { create(:a_book) }
  let(:another_book) { create(:another_book) }

  context 'When having a new cart' do
    let(:a_cart) { Cart.create() }
    it 'should be empty' do
      expect(a_cart).to be_empty
    end

    it 'should have a zero amount of books' do
      expect(a_cart.amount_of_books).to be 0
    end

    context 'and you add it a book' do
      before do
        a_cart.add(a_book, 1)
      end

      it 'should not be empty' do
        expect(a_cart).not_to be_empty
      end

      it 'should have 1 book' do
        expect(a_cart.amount_of_books).to eq 1
      end

      context 'and you add other book' do
        before do
          a_cart.add(a_book, 1)
        end
        it 'should have 2 books' do
          expect(a_cart.amount_of_books).to eq 2
        end

        it 'should have the same book twice' do
          expect(a_cart.occurrences_of(a_book)).to eq 2
        end
      end
    end

    context 'and you add a non positive amount of books' do
      it 'should raise an error' do
        expect { a_cart.add(a_book, 0) }.to raise_error(Cart.error_message_for_non_positive_amount_of_books)
      end
    end

    context 'and you add several valid books' do
       before do
        a_cart.add(another_book, 2)
        a_cart.add(a_book, 4)
      end

      it 'should have that amount of that books' do
        expect(a_cart.occurrences_of(a_book)).to eq 4
      end

      it 'should return a hash with its ISBN and the quantity' do
        expect(a_cart.occurrences_of(another_book)).to eq 2
        expect(a_cart.occurrences_of(a_book)).to eq 4
      end
    end
  end
end
