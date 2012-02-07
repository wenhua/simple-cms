(function() {
  var App, Content, old,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  old = function() {
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
  };

  Content = (function(_super) {

    __extends(Content, _super);

    function Content() {
      Content.__super__.constructor.apply(this, arguments);
    }

    Content.configure('Content', 'nav_widget');

    return Content;

  })(Spine.Model);

  App = (function(_super) {

    __extends(App, _super);

    function App() {
      App.__super__.constructor.apply(this, arguments);
    }

    App.prototype.elements = {
      '#admin-o': 'adminBtn'
    };

    App.prototype.construtor = function() {
      return App.__super__.construtor.apply(this, arguments);
    };

    return App;

  })(Spine.Controller);

  $(function() {
    return old();
  });

}).call(this);
