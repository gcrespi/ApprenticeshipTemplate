class BooksController < ApplicationController
  def index
    render template: 'books/index', locals: { :books => Book.all }
  end

  def show
    render template: 'books/show', locals: { :book => Book.find(params[:id]) }
  end
end
