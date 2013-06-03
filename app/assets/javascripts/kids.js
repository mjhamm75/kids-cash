$( document ).ready(function() {
  "use strict";

  $("tr[data-link]").click(function() {
    var that = $(this);
    window.location = that.data("link");
  });

  $('#quick-add-button').click(function() {
    flipModals('#index', '#add-modal');
  });

  $('#add-close').click(function() {
    flipModals('#add-modal', '#index');
    clearDiv('#add-modal');
  });

  $('#add-kid').click(function() {
    flipModals('#index', '#add-kid-modal');
  });

  $('#add-kid-close').click(function() {
    flipModals('#add-kid-modal', '#index');
    clearDiv('#add-kid-modal');
  });

  var clearDiv = function(div) {
    $(':input:not(:button)', div).val([]);
  };

  var flipModals = function(divHide, divShow) {
    $(divHide).hide();
    $(divShow).show();
  };

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
        var row = $('#kids tr td').filter(function() {
          return $(this).text() === name;
        });
        var current = $(row).siblings().find('.money').text();
        var amount = $('#transaction-amount').val();
        $(row).siblings().find('.money').text(Number(current) + Number(amount));
        flipModals('#add-modal', '#index');
        clearDiv('#add-modal');
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
      flipModals('#add-kid-modal', '#index');
      clearDiv('#add-kid-modal');
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