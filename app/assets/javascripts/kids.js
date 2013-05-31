$( document ).ready(function() {
  "use strict";

  $("tr[data-link]").click(function() {
    var that = $(this);
    window.location = that.data("link");
  });

  $('#quick-add-button').click(function() {
    $('#modal-name').text("Quick Add");
    $('#add-modal').modal();
  });

  $('#add-button').click(function() {
    $('#modal-name').text("Add Transaction");
    $('#add-name').hide();
    $('#add-name').val($('#kid-name').text());
    $('#add-modal').modal();
  });

  $('#add-kid').click(function() {
    $('#modal-name').text("Add Kid");
    $('#add-kid-modal').modal();
  });

  $('#add-finish').click(function() {
    var name = $('#add-name option:selected').val();
    var amount = $('#transaction-amount').val();
    var comment = $('#add-comment').val();
    var req = $.ajax({
      url: "kids/add-transaction",
      data: { name: name, amount: amount, comment: comment },
      type: "POST",
      dataType: "json",
      success: function() {
        $('#add-modal').modal('hide');
        var row = $('#kids tr td').filter(function() {
          return $(this).text() === name;
        });
        var current = $(row).siblings().find('.money').text();
        var amount = $('#transaction-amount').val();
        $(row).siblings().find('.money').text(Number(current) + Number(amount));
        $('#add-name option:selected').val("");
        $('#transaction-amount').val("");
        $('#add-comment').val("");
      }
    });
    req.done();
  });

  $('#add-kid-finish').click(function() {
    var name = $('#kid-name').val();
    var balance = $('#kid-balance').val();
    var req = $.ajax({
      url: "kids/add-kid",
      data: { name: name, balance: balance },
      type: "POST",
      dataType: "json"
    });
    var success = function() {
      $('#add-kid-modal').modal('hide');
      $('#kid-name').val("");
      $('#kid-balance').val("");
      $('#kids tr:last').after("<tr><td>" + name + "</td><td>$ " + balance + "</td></tr>");
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

  $('#kid-balance').priceFormat({
    prefix: "",
    allowNegative: true
  });
});