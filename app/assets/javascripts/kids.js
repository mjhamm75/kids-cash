$( document ).ready(function() {
  "use strict";

  $("tr[data-link]").click(function() {
    var that = $(this);
    window.location = that.data("link");
  });

  $('#quick-add-button').click(function() {
    $('#index').hide();
    $('#add-modal').show();
  });

  $('#add-button').click(function() {
    $('#modal-name').text("Add Transaction");
    $('#add-name').hide();
    $('#add-name').val($('#kid-name').text());
    $('#add-modal').modal();
  });

  $('#add-close').click(function() {
    $('#add-modal').hide();
    $('#add-name option:selected').val("");
    $('#transaction-amount').val("");
    $('#add-comment').val("");
    $('#index').show();
  });

  $('#add-kid').click(function() {
    $('#index').hide();
    $('#add-kid-modal').show();
  });

  $('#add-kid-close').click(function() {
    $('#add-kid-modal').hide();
    $('#kid-name').val("");
    $('#kid-balance').val("");
    $('#index').show();
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
        var row = $('#kids tr td').filter(function() {
          return $(this).text() === name;
        });
        var current = $(row).siblings().find('.money').text();
        var amount = $('#transaction-amount').val();
        $(row).siblings().find('.money').text(Number(current) + Number(amount));
        $('#add-modal').hide();
        $('#add-name option:selected').val("");
        $('#transaction-amount').val("");
        $('#add-comment').val("");
        $('#index').show();
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
      $('#add-kid-modal').hide();
      $('#kid-name').val("");
      $('#kid-balance').val("");
      $('#index').show();
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

  var metas = document.getElementsByTagName('meta');
  var i;
  if (navigator.userAgent.match(/iPhone/i)) {
    for (i=0; i<metas.length; i++) {
      if (metas[i].name == "viewport") {
        metas[i].content = "width=device-width, minimum-scale=1.0, maximum-scale=1.0";
      }
    }
    document.addEventListener("gesturestart", gestureStart, false);
  }
  function gestureStart() {
    for (i=0; i<metas.length; i++) {
      if (metas[i].name == "viewport") {
        metas[i].content = "width=device-width, minimum-scale=0.25, maximum-scale=1.6";
      }
    }
  }
});