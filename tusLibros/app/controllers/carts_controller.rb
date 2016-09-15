class CartsController < ApplicationController
  before_action :assert_authenticated
  around_action :assert_resource_found, only: [:list]
  around_action :assert_resource_recorded, only: [:create]
  around_action :assert_resource_for_request_existence, except: [:list]
  before_action :assert_cart_belongs_to_current_user, except: [:create]
  before_action :assert_active_cart, only: [:list, :add_books, :checkout]

  def list
    cart = Cart.find(params[:cart_id])
    render json: cart.list_cart, status: :ok
  end

  def add_books
    cart = Cart.find(params[:cart_id])
    book = Book.find_by!(:isbn => params[:isbn])
    cart.add(book, params[:quantity].to_i)
    render nothing: true, status: :ok
  end

  def create
    cart = Cart.create!(user_id: session[:user_id])
    render json: {cart_id: cart.id}, status: :created
  end

  def checkout
    cart = Cart.find(params[:cart_id])
    Cashier.new(MerchantProcessor.new).checkout(cart, create_card_from_params(params))
    render nothing: true, status: :ok
  end

  private
    def create_card_from_params(params)
      CreditCard.create(owner: params[:cco], number: params[:ccn], expiration_date: Date.parse(params[:cced]))
    end

    def assert_cart_belongs_to_current_user
      error = self.class.error_message_for_inaccessible_cart
      cart = Cart.find(params[:cart_id])
      render json: {error: error}, status: :unauthorized unless cart_belongs_to_current_user(cart)
    end

    def assert_active_cart
      unless Cart.find(params[:cart_id]).active?
        render json: { error: self.class.error_message_for_expired_cart}, status: :unprocessable_entity
      end
    end

    def cart_belongs_to_current_user(cart)
      cart.user_id == session[:user_id]
    end

  def self.error_message_for_should_first_login
    'You have to be logged in first'
  end

  def self.error_message_for_inaccessible_cart
    'You do not have access to this cart'
  end

  def self.error_message_for_expired_cart
    'The cart has already expired'
  end
end
