class CartsController < ApplicationController
  include WithUserCredentials

  def list
    cart_session = CartSession.find_by_cart_id!(params.require(:cart_id))
    render json: cart_session.get_cart, status: :ok
  end

  def add_books
    cart_session = CartSession.find_by_cart_id!(params.require(:cart_id))
    book = Book.find_by!(:isbn => params.require(:isbn))
    cart_session.add(book, params.require(:quantity).to_i)
    render nothing: true, status: :ok
  end

  def create
    user = authenticate_user_with(params.require(:username), params.require(:password))
    cart_session = CartSession.create_with_cart!(user_id: user.id)
    render json: cart_session.get_cart, status: :created
  end

  def checkout
    cart_session = CartSession.find(params.require(:cart_id))
    Cashier.new(MerchantProcessor.new).checkout(cart_session, CreditCard.create!(credit_card_params))
    render nothing: true, status: :ok
  end

  private
    def credit_card_params
      params.require(:credit_card).permit(:owner, :number, :expiration_date)
    end
end
