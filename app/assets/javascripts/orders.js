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
