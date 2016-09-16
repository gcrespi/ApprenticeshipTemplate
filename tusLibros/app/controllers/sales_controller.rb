class SalesController < ApplicationController
  include WithUserAuthentication
  before_action :assert_authenticated

  def list_purchases
    render json: Sale.where(user_id: session[:user_id])
  end
end
