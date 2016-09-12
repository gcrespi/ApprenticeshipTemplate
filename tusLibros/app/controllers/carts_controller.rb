class CartsController < ApplicationController
  def add_books
    cart = Cart.find(params[:cart_id])
    cart.add(Book.find_by(:isbn => params[:isbn]), params[:quantity].to_i)
    render nothing: true
  end

  def create
    if session[:user_id]
      Cart.create(user_id: session[:user_id])
    else
      raise 'No hay usuario logueado!'
    end
    render nothing: true
  end

  def checkout
    cart = Cart.find_by(id: params[:cartId])
    if cart_belongs_to_current_user(cart)
      credit_card = create_cart_from_params(params)
      Cashier.new(MerchantProcessor.new).checkout(cart, credit_card)
      render json: { code: 0 }
    else
      render json: { code: 1, error_description: self.class.error_message_for_inaccessible_cart }
    end
  end

  def create_cart_from_params(params)
    CreditCard.create(owner: params[:cco], number: params[:ccn], expiration_date: Date.parse(params[:cced]))
  end

  def cart_belongs_to_current_user(cart)
    !cart.nil? && cart.user_id == session[:user_id]
  end

  def self.error_message_for_inaccessible_cart
    'You do not have access to this cart'
  end
end
