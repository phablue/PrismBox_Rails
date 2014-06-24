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
    if @user.save
      update_current_borrowed_state(@user)
      redirect_to @user, notice: notice_message(@user.name, "created")
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_parameter)
      redirect_to @user, notice: notice_message(@user.name, "updated")
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to '/'
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_parameter
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :department)
  end

  def update_current_borrowed_state (user)
    user.update_attributes(current_borrowed_laptop: "Not Yet", current_borrowed_date: "N/A")
  end

  def notice_message (user_name, action)
    "#{user_name} was successfully #{action}."
  end
end
