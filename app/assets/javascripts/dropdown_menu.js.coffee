class DropDownMenu
  constructor: ->

  dropdownMenu: ->
    @mouseToggle ".nav-signin-title"
    @mouseToggle ".nav-account-dropdown-menu"

  mouseToggle: (element) ->
    this.mouseOver element
    this.mouseLeave element

  mouseOver: (element) ->
    $(element).mouseover( =>
      @toggleClass "nav-account-dropdown-menu", "nav-account-dropdown-menu open" )

  mouseLeave: (element) ->
    $(element).mouseleave( =>
      @toggleClass "nav-account-dropdown-menu open", "nav-account-dropdown-menu" )

  toggleClass: (remove, add) ->
    $(".nav-account-dropdown-menu").removeClass(remove).addClass(add)

window.DropDownMenu = DropDownMenu
