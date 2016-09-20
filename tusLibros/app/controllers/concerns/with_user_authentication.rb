module WithUserAuthentication
  ERROR_MESSAGE_FOR_SHOULD_FIRST_LOGIN = 'You have to be logged in first'

  def assert_authenticated
    raise LoginRequiredException, ERROR_MESSAGE_FOR_SHOULD_FIRST_LOGIN if session[:user_id].nil?
  end
end