class CartsController < ApplicationController
  include WithUserAuthentication

  before_action :assert_authenticated

  def list
    cart = CartSession.find_with_owner(params[:cart_id], session[:user_id])
    render json: cart.list_cart, status: :ok
  end

  def add_books
    cart = CartSession.find_with_owner(params[:cart_id], session[:user_id])
    book = Book.find_by!(:isbn => params[:isbn])
    cart.add(book, params[:quantity].to_i)
    render nothing: true, status: :ok
  end

  def create
    cart = CartSession.create_with_cart!(user_id: session[:user_id])
    render json: {cart_id: cart.id}, status: :created
  end

  def checkout
    cart = CartSession.find_with_owner(params[:cart_id], session[:user_id])
    Cashier.new(MerchantProcessor.new).checkout(cart, CreditCard.create!(credit_card_params))
    render nothing: true, status: :ok
  end

  private
    def credit_card_params
      params.require(:credit_card).permit(:owner, :number, :expiration_date)
    end
end
