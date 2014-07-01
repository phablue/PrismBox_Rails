module ApplicationHelper
  def current_user
    User.find_by_email(session[:user_id])
  end

  def title_url_by_user
    if current_user.nil?
      return "/"
    else
      if current_user.admin
        return admin_url
      end
      "/"
    end
  end
end
