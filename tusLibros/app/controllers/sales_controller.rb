class SalesController < ApplicationController
  def list_purchases
    render json: Sale.all
  end
end
