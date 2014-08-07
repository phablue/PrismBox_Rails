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
      change_user_rent_status("REQUEST", "REQUEST")
      redirect_to @order, notice: 'Successfully ordered.'
    else
      render "new"
    end
  end

  def edit
    session[:laptop_id] = Laptop.find(@order.laptop_id)
  end

  def update
    confirm(@order)
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
  def index_by state
    Order.where(order_status: state)
  end

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

  def change_user_rent_status laptop, date
    current_user.update_attributes(current_borrowed_laptop: laptop)
    current_user.update_attributes(current_borrowed_date: date)
  end

  def confirm new_order
    if new_order.update_attributes(order_status: "CONFIRMED")
      change_laptop_status("RENTED")
      change_user_rent_status(new_order.laptop_serial_number, new_order.updated_at)
      redirect_to @order, notice: 'Order status was successfully confirmed.'
    else
      render "edit"
    end
  end
end
