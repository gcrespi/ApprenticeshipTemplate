class CartsController < ApplicationController
  include WithUserCredentials

  def list
    cart = CartSession.find(params.require(:cart_id))
    render json: cart.list_cart, status: :ok
  end

  def add_books
    cart = CartSession.find(params.require(:cart_id))
    book = Book.find_by!(:isbn => params.require(:isbn))
    cart.add(book, params.require(:quantity).to_i)
    render nothing: true, status: :ok
  end

  def create
    user = authenticate_user_with(params.require(:username), params.require(:password))
    cart = CartSession.create_with_cart!(user_id: user.id)
    render json: {cart_id: cart.id}, status: :created
  end

  def checkout
    cart = CartSession.find(params.require(:cart_id))
    Cashier.new(MerchantProcessor.new).checkout(cart, CreditCard.create!(credit_card_params))
    render nothing: true, status: :ok
  end

  private
    def credit_card_params
      params.require(:credit_card).permit(:owner, :number, :expiration_date)
    end
end
