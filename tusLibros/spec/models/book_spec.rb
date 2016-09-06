require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'When creating a book' do
    let(:a_book) { Book.create(:isbn => '9788427811362', :price => 20) }

    it 'should have an isbn and a price' do
      expect(a_book).to respond_to :isbn
      expect(a_book).to respond_to :price
    end
  end
end
