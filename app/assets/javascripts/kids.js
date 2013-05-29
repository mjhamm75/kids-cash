$( document ).ready(function() {
  $("tr[data-link]").click(function() {
    var that = $(this);
    window.location = that.data("link");
  });
});