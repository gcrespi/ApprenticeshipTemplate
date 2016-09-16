class BooksController < ApplicationController

  def index
    render json: Book.all
  end

  def show
      render json: Book.find(params.require(:id))
  end
end
