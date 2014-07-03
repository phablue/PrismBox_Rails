class Orders
  constructor: ->

  getClickedTargetDataID: ->
    $("[data-id='ordersMng'] li").click((e) ->
      $(e.target).attr("data-id"))

window.Orders = Orders
