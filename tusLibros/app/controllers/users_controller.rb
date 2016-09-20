class UsersController < ApplicationController

  ERROR_MESSAGE_FOR_INVALID_CREDENTIALS = 'The combination of user and password is invalid'

  def request_login
    user = User.find_by_name(params.require(:username))
    raise FailedLoginException, ERROR_MESSAGE_FOR_INVALID_CREDENTIALS unless valid_credentials user
    session[:user_id] = user.id
    render nothing: true, status: :ok
  end

  def valid_credentials(user)
    !user.nil? && user.authenticate(params.require(:password))
  end
end
