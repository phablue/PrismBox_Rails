class DropDownMenu
  constructor: ->

  dropdownMenu: ->
    @mouseToggle ".dropdown-toggle"
    @mouseToggle ".dropdown-menu"

  mouseToggle: (element) ->
    this.mouseOver element
    this.mouseLeave element

  mouseOver: (element) ->
    $(element).mouseover( =>
      @toggleClass "dropdown", "dropdown open" )

  mouseLeave: (element) ->
    $(element).mouseleave( =>
      @toggleClass "dropdown open", "dropdown" )

  toggleClass: (remove, add) ->
    $(".dropdown").removeClass(remove).addClass(add)

window.DropDownMenu = DropDownMenu
