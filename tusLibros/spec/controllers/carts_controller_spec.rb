require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:a_cart) { CartSession.create_with_cart!(user: create(:user)) }

  context 'When having an active cart create by current user' do
    before do
      session[:user_id] = a_cart.user_id
    end
    context 'When requesting to add 2 books to a cart' do
      let(:a_book) { create(:a_book) }

      before do
        post :add_books, {cart_id: a_cart.id, isbn: a_book.isbn, quantity: 2}
      end

      it 'the cart should have that book twice' do
        expect(a_cart.occurrences_of(a_book)).to eq 2
      end
    end

    context 'When requesting to checkout a cart' do

      let(:checkout_params) { {
          cart_id: a_cart.id,
          credit_card: {
              number: a_credit_card.number,
              owner: a_credit_card.owner,
              expiration_date: a_credit_card.expiration_date
          }
        }
      }

      context 'and the cart is not empty' do
        let(:a_price) { 30 }
        let(:a_book) { create(:a_book, price: a_price) }
        let(:a_credit_card) { build(:credit_card) }
        let(:params) { {
            'creditCardNumber' => a_credit_card.number,
            'creditCardExpiration' => a_credit_card.expiration,
            'creditCardOwner' => a_credit_card.owner,
            'transactionAmount' => a_price.to_s
        }
        }

        before do
          a_cart.add(a_book, 1)
        end

        context 'a user is logged and is the owner of the cart' do
          before do
            session[:user_id] = a_cart.user.id
            stub_request(:post, Rails.configuration.merchant_processor_url)
                .with(:body => params)
                .to_return(:status => 200, :body => '0|OK', :headers => {})
            post :checkout, checkout_params
          end

          it 'the cart should be no more' do
            expect(Cart.find_by(id: a_cart.id)).to be_nil
          end
        end

        context 'and the user logged is not the owner of the cart' do
          before do
            session[:user_id] = a_cart.user.id + 1
            post :checkout, checkout_params
          end

          it 'should responds that the cart is not accessible' do
            json_response = JSON.parse(response.body)
            expect(response).to have_http_status(:forbidden)
            expect(json_response['error']).to eq(CartSession.error_message_for_inaccessible_cart)
          end
        end
      end
    end

    context 'When requesting to list a cart with books' do
      let(:a_book) { create(:a_book) }
      let(:another_book) { create(:another_book) }

      before do
        a_cart.add(a_book, 3)
        a_cart.add(another_book, 2)
        get :list, { cart_id: a_cart.id }
      end

      it 'the response should indicate the quantity of each book' do
        expect(JSON.parse(response.body)).to eq a_cart.list_cart.as_json
      end
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

      context 'and 30 minutes in the future...' do
        let!(:a_cart_session) { create(:cart_session, user: a_user) }
        before do
          Timecop.travel(30.minutes.from_now)
        end

        context 'and requesting to list the cart' do
          before do
            get :list, { cart_id: a_cart_session.id }
          end

          it 'should respond an unprocessable entity status' do
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.body).to be_include CartSession.error_message_for_expired_cart
          end
        end
      end
    end
  end
end
