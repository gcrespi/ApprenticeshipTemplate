class CartsController < ApplicationController
  def add_books
    cart = Cart.find(params[:cart_id])
    cart.add(Book.find_by(:isbn => params[:isbn]), params[:quantity].to_i)
    render :nothing => true
  end
end
