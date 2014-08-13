class OrdersController < ApplicationController
  before_action :admin_authorize, except:[:show, :new, :create, :destroy]
  before_action :get_order, only:[:show, :edit, :update, :destroy, :get_session_laptop_id]
  before_action :get_session_laptop_id, only:[:edit, :update, :destroy]
  before_action :check_available_rental, :check_available_laptop_state, only:[:create]

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
    @order.attributes = {laptop_id: session[:laptop_id].id, user_id: current_user.id, order_status: "PROCESSING"}
    if @order.save
      change_laptop_status("RESERVED")
      change_user_rent_status("REQUEST", "REQUEST")
      redirect_to @order, notice: 'Successfully ordered.'
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @order.update_attributes(order_parameter)
      change_others_status(@order.order_status, @order)
      redirect_to @order, notice: 'Order status was successfully updated.'
    else
      render "edit"
    end
  end

  def confirm_all_new_orders
    orders = Order.where(order_status: "PROCESSING")
    orders.each do |order|
      session[:laptop_id] = Laptop.find(order.laptop_id)
      order.update_attributes(order_status: "CONFIRMED")
      change_others_status(order.order_status, order)
    end
    redirect_to admin_url, notice: 'All new orders status was successfully confirmed.'
  end

  def destroy
    unless current_user.admin
      if @order.order_status == "CONFIRMED"
        redirect_to "/", notice: "You can't cancel a order confirmed."
      else
        cancel_order("/")
      end
    else
      cancel_order(orders_url)
    end
  end

  def cancel_order url
    @order.destroy
    change_laptop_status("STOCKS")
    change_user_rent_status("Not Yet", "N/A")
    redirect_to url, notice: "Order was successfully canceled"
  end

  private
  def index_by state
    Order.where(order_status: state)
  end

  def get_session_laptop_id
    session[:laptop_id] = Laptop.find(@order.laptop_id)
  end

  def get_order
    @order = Order.find(params[:id])
  end

  def order_parameter
    params.require(:order).permit(:full_name, :email, :laptop_serial_number, :order_status)
  end

  def check_available_rental
    unless current_user.current_borrowed_laptop == "Not Yet"
      redirect_to "/", notice: "You can't borrow before returning a laptop borrowed"
    end
  end

  def check_available_laptop_state
    unless session[:laptop_id].state == "STOCKS"
      redirect_to({controller:'catalog', action:'index'}, notice: "Chosen laptop is already #{session[:laptop_id].state.downcase}")
    end    
  end

  def change_laptop_status statement
    session[:laptop_id].update_attributes(state: statement)
    session[:laptop_id] = nil
  end

  def change_user_rent_status laptop, date
    current_user.update_attributes(current_borrowed_laptop: laptop, current_borrowed_date: date)
  end

  def change_others_status statement, order
    if statement == "CONFIRMED"
      change_laptop_status("RENTED")
      change_user_rent_status(order.laptop_serial_number, order.updated_at.to_date)
    else
      change_laptop_status("RESERVED")
      change_user_rent_status("REQUEST", "REQUEST")
    end
  end
end
