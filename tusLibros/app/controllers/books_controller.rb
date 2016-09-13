class BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def show
    begin
      render json: Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      render json: { error: error.message }, status: :not_found
    end
  end
end
