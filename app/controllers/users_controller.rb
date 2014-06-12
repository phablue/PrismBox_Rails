class UsersController < ApplicationController
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
      @user.update_attributes(current_borrowed_laptop: "Not Yet", current_borrowed_date: "N/A")
      redirect_to @user, notice: "#{@user.name} was successfully created."
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_parameter)
      redirect_to @user, notice: "#{@user.name} was successfully updated."
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
end
