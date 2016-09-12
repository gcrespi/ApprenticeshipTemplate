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
end
