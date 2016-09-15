class BooksController < ApplicationController

  before_action :assert_resource_found, only: [:show]

  def index
    render json: Book.all
  end

  def show
      render json: Book.find(params[:id])
  end
end
