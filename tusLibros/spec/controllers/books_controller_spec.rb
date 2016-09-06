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
    before do
      Book.create(:isbn => '9788427811362', :price => 20)
    end
    context 'and request the book with the id 1' do
      before do
        get :show, { :id => 1 }
      end

      it 'should have a success response' do
        assert_response :success
      end
    end
  end
end
