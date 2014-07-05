class Orders
  constructor: ->

  getClickedTargetDataID: (callback) ->
    $(".order_state a").click((e) ->
      callback($(e.target).attr("data-id")))

  chosenOrdersStatementType: (ordersState) ->
    $.post("index", {chosen_orders_statement: ordersState})

window.Orders = Orders
