class LaptopsController < ApplicationController
  before_action :admin_authorize, except:[:index, :show]
  before_action :get_laptop, only:[:show, :edit, :update, :destroy]

  def index
    @laptops = Laptop.all
  end

  def show
  end

  def new
    @laptop = Laptop.new
  end

  def create
    @laptop = Laptop.create(laptop_parameter)
    if @laptop.save
      @laptop.update_attributes(state: "STOCKED")
      redirect_to @laptop, notice: 'Laptop was successfully created.'
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @laptop.update_attributes(laptop_parameter)
      redirect_to @laptop, notice: 'Laptop was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    @laptop.destroy
    redirect_to laptops_url
  end

  private

  def get_laptop
    @laptop = Laptop.find(params[:id])
  end

  def laptop_parameter
    params.require(:laptop).permit(:serial_number, :model_, :hdd_size, :cpu_speed, :ram, :screen_size, :purchased_date, :state)
  end
end
