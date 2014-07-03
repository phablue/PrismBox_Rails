(function() {
  var Account = {
    dropdownMenu: function() {
      this.mouseToggle(".dropdown-toggle");
      this.mouseToggle(".dropdown-menu");
    },

    mouseToggle: function(element) {
      Account.mouseOver(element);
      Account.mouseLeave(element);
    },

    mouseOver: function(element) {
      $(element).mouseover(function () {
        Account.toggleClass("dropdown", "dropdown open");
      });
    },

    mouseLeave: function(element) {
      $(element).mouseleave(function () {
        Account.toggleClass("dropdown open", "dropdown");
      });
    },

    toggleClass: function(remove, add) {
      $(".dropdown").removeClass(remove).addClass(add);
    }
  };

  window.Account = Account

})();

+$(function() {
  Account.dropdownMenu();
});