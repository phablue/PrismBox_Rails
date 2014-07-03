(function() {
  var Orders = {
    getClickedTargetDataID: function() {
      $("[data-id='ordersMng'] li").click(function(e){
        return $(e.target).attr("data-id");
      });
    }
  };

  window.Orders = Orders;

})();

var ClickedTargetDataID = function() {
  Orders.getClickedTargetDataID()
};

$(function() {
  ClickedTargetDataID()
});

$(document).on('page:load', ClickedTargetDataID);
