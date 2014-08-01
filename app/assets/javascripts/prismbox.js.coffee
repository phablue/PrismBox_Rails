prismboxUI = ->
  (new DropDownMenu).dropdownMenu()

$ ->
  prismboxUI()
  $(@).on('page:load', prismboxUI)