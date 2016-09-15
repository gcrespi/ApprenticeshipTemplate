module WithUserAuthentication
  def self.error_message_for_should_first_login
    'You have to be logged in first'
  end

  def assert_authenticated
    raise LoginRequiredException, self.class.error_message_for_should_first_login if session[:user_id].nil?
  end
end