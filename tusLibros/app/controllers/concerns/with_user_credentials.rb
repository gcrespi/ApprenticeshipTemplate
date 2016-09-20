module WithUserCredentials
  ERROR_MESSAGE_FOR_INVALID_CREDENTIALS = 'The username password combination is not correct'

  def authenticate_user_with(username, password)
    user = User.find_by_name(username)
    raise FailedLoginException, ERROR_MESSAGE_FOR_INVALID_CREDENTIALS unless valid_credentials(user, password)
    user
  end

  def valid_credentials(user, password)
    !user.nil? && user.authenticate(password)
  end
end