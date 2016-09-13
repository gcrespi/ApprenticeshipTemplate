class UsersController < ApplicationController

  def request_login
    user = User.find_by_name(params[:username])
    if user && user.password == params[:password]
      session[:user_id] = user.id
      render nothing: true, status: :ok
    else
      render json: { error: 'Failed authentication' }, status: 400
    end
  end
end
