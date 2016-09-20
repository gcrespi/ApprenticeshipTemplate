require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'When requesting the login page' do
    before do
      get :login
    end

    it 'should have a success response' do
      assert_response :success
    end
  end

  context 'When requesting to login ' do
    context 'and the user and passwords are correct' do
      let(:a_user) { create(:user) }
      before do
        post :request_login, { username: a_user.name, password: a_user.password }
      end

      it 'should have a success response' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'and the user does not exist' do
      before do
        post :request_login, { username: 'not a username', password: '' }
      end

      it 'should have an unauthorized error response' do
        expect(response).to have_http_status :unauthorized
        expect(response.body).to be_include UsersController::ERROR_MESSAGE_FOR_INVALID_CREDENTIALS
      end
    end

    context 'and the user exists but the password is incorrect' do
      let(:a_user) { create(:user) }
      before do
        post :request_login, { username: a_user.name, password: (a_user.password + 'a') }
      end

      it 'should have an unauthorized error response' do
        expect(response).to have_http_status :unauthorized
        expect(response.body).to be_include UsersController::ERROR_MESSAGE_FOR_INVALID_CREDENTIALS
      end
    end
  end
end
