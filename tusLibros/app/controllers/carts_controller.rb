class CartsController < ApplicationController
  def add_books
    cart = Cart.find(params[:cart_id])
    cart.add(Book.find_by(:isbn => params[:isbn]), params[:quantity].to_i)
    render nothing: true
  end

  def create
    if session[:user_id]
      cart = Cart.create(user_id: session[:user_id])
    else
      raise 'No hay usuario logueado!'
    end
    render nothing: true
  end

  def checkout
    cart = Cart.find(params[:cartId])
    raise 'no tocarás el carrito de tu prójimo' unless cart_belongs_to_current_user(cart)
    credit_card = CreditCard.create(
        owner: params[:cco],
        number: params[:ccn],
        expiration_date: Date.parse(params[:cced])
    )
    Cashier.new(MerchantProcessor.new).checkout(cart, credit_card)
    render nothing: true
  end

  def cart_belongs_to_current_user(cart)
    !cart.nil? && cart.user_id == session[:user_id]
  end
end
