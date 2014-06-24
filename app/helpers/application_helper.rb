module ApplicationHelper
  def current_user
    User.find_by_email(session[:user_id])
  end
end
