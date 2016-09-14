class SalesController < ApplicationController

  def list_purchases
    if session[:user_id]
      render json: Sale.where(user_id: session[:user_id])
    else
      render nothing: true, status: :unauthorized
    end
  end
end
