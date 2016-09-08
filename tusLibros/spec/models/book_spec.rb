require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'When creating a book' do
    let(:a_book) { create(:a_book) }

    it 'should have an isbn and a price' do
      expect(a_book).to respond_to :isbn
      expect(a_book).to respond_to :price
    end
  end
end
