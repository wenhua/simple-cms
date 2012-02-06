(function() {

  $(function() {
    $("#sigup").click(function() {
      return $("#signup-form").modal();
    });
    $("#login-o").click(function() {
      $("#login-form").modal();
      return false;
    });
    return $("#signup-form > form").submit(function() {
      $.post('/users', {
        username: $("#username").val(),
        password: $("#password").val(),
        email: $("#email").val(),
        firstName: $("#firstName").val(),
        lastName: $("#lastName").val()
      }, function(data) {
        $("#signup-form").modal('hide');
        if ('success' !== data.result) return alert('对不起，注册用户出错，请稍后再试！');
      });
      return false;
    });
  });

}).call(this);
