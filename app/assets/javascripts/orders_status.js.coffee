class OrdersStatus
  constructor: ->

  ordersStatus: ->
    @getOrderStatusType(@chosenOrderStatusType)

  getOrderStatusType: (callback) ->
    $(".order_state a").click((e) ->
      callback($(e.target).attr("data-id")))

  chosenOrderStatusType: (ordersStatus) ->
    $.post("index", {chosen_orders_status: ordersStatus})

window.OrdersStatus = OrdersStatus
