class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def assert_resource_for_request_existence(&action)
    assert_resource_existence(:bad_request, &action)
  end

  def assert_resource_found(&action)
    assert_resource_existence(:not_found, &action)
  end

  def assert_resource_existence(http_code, &action)
    begin
      action.call
    rescue ActiveRecord::RecordNotFound => error
      render json: {error: error.message}, status: http_code
    end
  end

  def assert_resource_recorded
    begin
      yield
    rescue ActiveRecord::RecordNotSaved => error
      render json: {error: error.message}, status: :bad_request
    end
  end

  def assert_authenticated
    error = self.class.error_message_for_should_first_login
    render json: {error: error}, status: :unauthorized unless session[:user_id]
  end
end
