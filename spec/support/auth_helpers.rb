module AuthHelpers
  def auth_with user
    session[:user_id] = users(user).email
  end

  def clear_auth
    session.delete :user_id
  end
end
