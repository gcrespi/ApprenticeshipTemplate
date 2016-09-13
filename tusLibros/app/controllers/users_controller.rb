class UsersController < ApplicationController

  def request_login
    user = User.find_by_name(params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      render nothing: true, status: :ok
    else
      render json: { error: 'The combination of user and password is invalid' }, status: 400
    end
  end
end
