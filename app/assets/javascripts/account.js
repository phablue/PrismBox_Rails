(function() {
  var Account = {
    mouseToggle: function (element) {
      console.log (Account)
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
  Account.mouseToggle(".dropdown-toggle");
  Account.mouseToggle(".dropdown-menu"); 
});