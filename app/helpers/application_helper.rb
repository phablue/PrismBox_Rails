module ApplicationHelper
  def current_user
    User.find_by_email(session[:user_id])
  end

  def title_url_by_user
    if current_user.nil?
      "/"
    elsif current_user.admin
      admin_url
    end
  end
end
