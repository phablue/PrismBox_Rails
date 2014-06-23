class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authorize
  protect_from_forgery with: :exception

  protected

  def authorize
    unless User.find_by_email(session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

  def admin_authorize
    if User.find_by_email(session[:admin_id]).admin
      redirect_to '/', notice: "Sorry. This is a wrong access"
    end
  end
end
