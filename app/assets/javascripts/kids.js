$( document ).ready(function() {
  "use strict";

  $("tr[data-link]").click(function() {
    var that = $(this);
    window.location = that.data("link");
  });

  $('#add-transaction-button').click(function() {
    flipModals('#index', '#add-transaction-modal');
  });

  $('#add-transction-close').click(function() {
    flipModals('#add-transaction-modal', '#index');
    clearDiv('#add-transaction-modal');
  });

  $('#add-kid-button').click(function() {
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

  var formatAmount = function(amount) {
    while(amount.length < 3) {
      amount = amount + "0";
    }
    return amount;
  }

  $('#add-transaction-finish').click(function(data) {
    var name = $('#add-transaction-name option:selected').val();
    var amount = $('#add-transaction-amount').val();
    amount = formatAmount(amount);
    var comment = $('#add-transaction-comment').val();
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
        var amount = $('#add-transaction-amount').val();
        var total = (Number(current) + Number(amount)).toFixed(2);
        $(row).siblings().find('.money').text(total);
        flipModals('#add-transaction-modal', '#index');
        clearDiv('#add-transaction-modal');
      }
    });
    req.done();
  });

  $('#add-kid-finish').click(function() {
    var name = $('#add-kid-name').val();
    var balance = $('#add-kid-balance').val();
    var req = $.ajax({
      url: "kids/add-kid",
      data: { name: name, balance: balance },
      type: "POST",
      dataType: "json",
      success: function(data) {
        flipModals('#add-kid-modal', '#index');
        clearDiv('#add-kid-modal');
        $('#index table tr:last').after('<tr data-link="kids/"' + data.id + '><td>' + data.name + '</td><td><span>$</span><span class="money">' + data.balance + '</span></td></tr>');
        $('select option:last').after('<option>' + data.name + '</option>');
      }
    });
    req.done();
  });
});