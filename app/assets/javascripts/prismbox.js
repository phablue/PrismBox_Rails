var prismbox = function() {
  Account.dropdownMenu();
  Orders.getClickedTargetDataID()
};

$(function() {
  prismbox()
});

$(document)
  .on('page:load', prismbox);
