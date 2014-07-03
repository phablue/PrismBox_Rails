prismbox = ->
  (new Account).dropdownMenu()
  (new Orders).getClickedTargetDataID()

$ ->
  prismbox()
  $(@).on('page:load', prismbox)