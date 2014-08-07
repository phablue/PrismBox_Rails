class OrdersController < ApplicationController
  before_action :admin_authorize, except:[:show, :new, :create]
  before_action :get_order, only:[:show, :edit, :update, :destroy]

  def index
   if params[:state] == "all" || params[:state].nil?
      @orders = Order.all
    else
      @orders = index_by(params[:state].upcase)
    end
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_parameter)
    @order.attributes = {laptop_id: session[:laptop_id].id, user_id: current_user.id}
    if @order.save
      change_laptop_status("RESERVED")
      redirect_to @order, notice: 'Successfully ordered.'
    else
      render "new"
    end
  end

  def edit
  end

  def update
    session[:laptop_id] = Laptop.find(@order.laptop_id)
    if @order.update_attributes(order_parameter)
      check_order_status
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

  def change_laptop_status statement
    session[:laptop_id].update_attributes(state: statement)
    session[:laptop_id] = nil
  end

  def check_order_status
    if @order.order_status = "CONFIRMED"
      change_laptop_status("LEND")
    end
  end

  def index_by state
    Order.where(order_status: state)
  end
end
