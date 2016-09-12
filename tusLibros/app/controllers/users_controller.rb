class UsersController < ApplicationController
  def login
    render template: 'users/login'
  end

  def request_login
    user = User.find_by_name(params[:username])
    if user && user.password == params[:password]
      render template: 'users/successful_login'
    else
      flash[:error] = 'Failed Login!'
      redirect_to :login
    end
  end
end
