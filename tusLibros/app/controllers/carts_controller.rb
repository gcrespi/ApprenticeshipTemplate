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
    cart_session = CartSession.find_by_cart_id!(params.require(:cart_id))
    Cashier.new(MerchantProcessor.new).checkout(cart_session, CreditCard.create!(credit_card_params))
    render nothing: true, status: :ok
  end

  private
  def credit_card_params
    credit_card = params.require(:credit_card)
    expiration_date = credit_card.require(:expiration_date)
    {
        owner: credit_card.require(:owner),
        number: credit_card.require(:number),
        expiration_date: Date.new(expiration_date.require(:year).to_i, expiration_date.require(:month).to_i, 1)
    }
  end
end
