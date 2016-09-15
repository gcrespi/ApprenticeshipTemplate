#require_relative '../../app/models/exceptions/forbidden_exception'

class ApplicationController < ActionController::Base
  include WithErrorHandler
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_action :handle_domain_errors
end
