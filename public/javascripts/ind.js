(function() {
  var old;

  old = function() {
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

  (function() {
    var $, contencForm, contentTemp, loginForm, mainList, parseDate, signupForm, up;
    $ = jQuery;
    /* elements
    */
    loginForm = $('#login-form');
    signupForm = $('#signup-form');
    contencForm = $('#content-form');
    mainList = $('#main-list');
    up = $('#up');
    contentTemp = "    <h4>{{title}}</h4>    <p>{{createTime}}</p>    <p>{{updateTime}}</p>    <p><a href='/#/users/{{createUserId}}'>{{createUserName}}</a></p>";
    parseDate = function(date) {
      var d;
      d = new Date();
      d.setTime(date);
      return "" + (d.getFullYear()) + "/" + (d.getMonth() + 1) + "/" + (d.getDate()) + " " + (d.getHours()) + ":" + (d.getMinutes()) + ":" + (d.getSeconds());
    };
    return window.app = $.sammy(function() {
      var createContent, index, login, showContent, signup;
      index = function(ctx) {
        return true;
      };
      createContent = function(ctx) {
        return contencForm.modal();
      };
      login = function(ctx) {
        return loginForm.modal();
      };
      signup = function(ctx) {
        return signupForm.modal();
      };
      showContent = function(ctx) {
        return (this.load("/" + this.params['link'])).then(function(i) {
          var item, source, template;
          item = $.parseJSON(i);
          item.createTime = parseDate(item.createTime);
          item.updateTime = parseDate(item.updateTime);
          source = contentTemp;
          template = Handlebars.compile(source);
          return up.append(template(item));
        });
      };
      this.get('/#/', index);
      this.get('/#/new', createContent);
      this.get('/#/login', login);
      this.get('/#/signup', signup);
      return this.get('/#/:link', showContent);
    });
  })();

  $(function() {
    app.run('#/index');
    return old();
  });

}).call(this);
