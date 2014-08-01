class OrdersController < ApplicationController
  before_action :admin_authorize, except:[:show, :new, :create]
  before_action :get_order, only:[:show, :edit, :update, :destroy]

  def index
    puts params[:state] == "new"
    if params[:state] == "new"
      @orders = Order.where(order_state: "PROCESSING")
    elsif params[:state] == "confirmed"
      @orders = Order.where(order_state: "CONFIRMED")
    else
      @orders = Order.all
    end
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_parameter)
    if @order.save
      change_laptop_statment
      redirect_to @order, notice: 'Successfully ordered.'
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @order.update_attributes(order_parameter)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render "edit"
    end 
  end

  def destroy
    @order.destroy
    if current_user.admin
      redirect_to orders_url
    else
      redirect_to "/"
    end
  end

  private

  def get_order
    @order = Order.find(params[:id])
  end

  def order_parameter
    params.require(:order).permit(:full_name, :email, :laptop_serial_number, :order_status)
  end

  def change_laptop_statment
    session[:laptop_id].update_attributes(state: "RESERVED")
    session[:laptop_id] = nil
  end
end
