prismbox = ->
  account = new Account
  orders = new Orders
  account.dropdownMenu()
  orders.getClickedTargetDataID(orders.chosenOrdersStatementType)

$ ->
  prismbox()
  $(@).on('page:load', prismbox)