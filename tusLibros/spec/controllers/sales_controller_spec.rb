require 'rails_helper'

RSpec.describe SalesController, type: :controller do
  context 'When having a sale with 2 books' do
    let(:a_book) { create(:a_book) }
    let(:another_book) { create(:another_book) }
    let!(:a_sale) { Sale.create!(books: [a_book, a_book, another_book]) }

    context 'When requesting to list the sales' do
      before do
        post :list_purchases
      end
      it 'should respond the sales serialized' do
        serialized_item = {
            book: ActiveModelSerializers::SerializableResource.new(a_book, {}).serializable_hash,
            quantity: 2
        }
        another_serialized_item = {
            book: ActiveModelSerializers::SerializableResource.new(another_book, {}).serializable_hash,
            quantity: 1
        }
        serialized_sale = {id: a_sale.id, content: [ serialized_item, another_serialized_item ]}
        expect(response.body).to eq [serialized_sale].to_json
      end
    end
  end
end
