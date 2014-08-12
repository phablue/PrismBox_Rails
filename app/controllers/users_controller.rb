class UsersController < ApplicationController
  skip_before_action :authorize, except:[:index]
  before_action :admin_authorize, only:[:index]
  before_action :get_user, only:[:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_parameter)
    @user.attributes = {current_borrowed_laptop: "Not Yet", current_borrowed_date: "N/A"}
    if @user.save
      session[:user_id] = @user.email
      redirect_to @user, notice: notice_message("#{@user.first_name} #{@user.last_name}", "created")
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_parameter)
      redirect_to @user, notice: notice_message("#{@user.first_name} #{@user.last_name}", "updated")
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_parameter
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :department, :current_borrowed_laptop, :current_borrowed_date)
  end

  def notice_message (user_name, action)
    "#{user_name} was successfully #{action}."
  end
end
