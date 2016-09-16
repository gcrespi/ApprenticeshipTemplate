class UsersController < ApplicationController

  def request_login
    user = User.find_by_name(params.require(:username))
    raise UnauthorizedException, 'The combination of user and password is invalid' unless user.authenticate(params.require(:password))
    session[:user_id] = user.id
    render nothing: true, status: :ok
  end
end
