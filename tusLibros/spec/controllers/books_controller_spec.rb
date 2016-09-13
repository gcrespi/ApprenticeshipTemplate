require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  context 'When requesting the index of books' do
    before do
      get :index
    end

    it 'should have a success response' do
      assert_response :success
    end
  end

  context 'When having a book created' do
    let(:a_book) { Book.create(:isbn => '9788427811362', :price => 20) }

    context 'and request to show the book' do
      before do
        get :show, { :id => a_book.id }
      end

      it 'should have a success response' do
        assert_response :success
      end
    end

    context 'and request to show the a non existent book' do
      before do
        get :show, { :id => a_book.id + 1 }
      end

      it 'should have a success response' do
        assert_response :not_found
      end
    end
  end
end
