(function() {
  var hideLabel, switchAdmin;

  hideLabel = function() {
    return $('label').hide();
  };

  switchAdmin = function() {
    $('#admin-o').click(function() {
      $('#admin-o-e').show();
      return $(this).hide();
    });
    return $('#admin-o-e').hide().click(function() {
      $('#admin-o').show();
      return $(this).hide();
    });
  };

  $(function() {
    return switchAdmin();
  });

}).call(this);
