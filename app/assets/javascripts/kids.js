$( document ).ready(function() {
  $("tr[data-link]").click(function() {
    var that = $(this);
    window.location = that.data("link");
  });

  $('#quick-add-button').click(function() {
    $('#add-modal').modal();
  });

  $('#add-button').click(function() {
    $('#modal-name').val("Add Transaction");
    $('#add-name').hide();
    $('#add-name').val($('#kid-name').text());
    $('#add-modal').modal();
  });

  $('#add-kid').click(function() {
    $('#add-kid-modal').modal();
  });

  $('#add-finish').click(function() {
    var name = $('#add-name option:selected').val();
    var amount = $('#transaction-amount').val();
    var comment = $('#add-comment').val();
    var req = $.ajax({
      url: "http://99.44.242.76:3000/kids/add-transaction",
      data: { name: name, amount: amount, comment: comment },
      type: "POST",
      dataType: "json"
    });
    var success = function() {
      $('#add-modal').modal('hide');
    };
    req.done(success);
  });

  $('#transaction-amount').priceFormat({
    prefix: "",
    allowNegative: true
  });

  $('#kid_balance').priceFormat({
    prefix: "",
    allowNegative: true
  });
});