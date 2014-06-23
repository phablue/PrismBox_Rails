class SessionsController < ApplicationController
  skip_before_action :authorize, :admin_authorize

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.email
      if user.admin
        redirect_to admin_url
      else
        redirect_to '/'
      end
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
