prismboxUI = ->
  (new DropDownMenu).dropdownMenu()
  (new OrdersStatus).ordersStatus()

$ ->
  prismboxUI()
  $(@).on('page:load', prismboxUI)