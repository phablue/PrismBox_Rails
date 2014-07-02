class OrdersController < ApplicationController
  before_action :admin_authorize, except:[:show, :new, :create]
  before_action :get_order, only:[:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_parameter)
    if @order.save
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
    redirect_to "/"
  end

  private

  def get_order
    @order = Order.find(params[:id])
  end

  def order_parameter
    params.require(:order).permit(:full_name, :email, :laptop_serial_number, :order_confirm)
  end
end
