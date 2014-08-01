module AdminHelper
  def new_orders
    Order.where(order_status: "PROCESSING")
  end
end
