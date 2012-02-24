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
    var $, contencForm, contentTemp, loginForm, mainArea, mainList, navTemp, parseDate, signupForm, subnav, up;
    $ = jQuery;
    /* elements
    */
    loginForm = $('#login-form');
    signupForm = $('#signup-form');
    contencForm = $('#content-form');
    mainList = $('#main-list');
    mainArea = $('#main-area');
    up = $('#up');
    subnav = $('#subnav');
    contentTemp = "    <h4>{{title}}</h4>    <p>{{createTime}}</p>    <p>{{updateTime}}</p>    <p><a href='/#/users/{{createUserId}}'>{{createUserName}}</a></p>";
    navTemp = "    <ul class='nav nav-pills'>        {{#navItems}}          {{#if dropdown}}              <li class='dropdown'><a class='dropdown-toggle' data-toggle='dropdown' href='{{link}}'n>{{title}}<b class='caret'></b></a>                <ul class='dropdown-menu'>                    {{#dropdown}}                    <li><a href='/#/{{link}}'>{{title}}</a></li>                    {{/dropdown}}                </ul>              </li>          {{else}}              <li><a href='/#/{{link}}'>{{title}}</a></li>          {{/if}}        {{/navItems}}        <li><a href='/system'>系统</a></li>    </ul>";
    parseDate = function(date) {
      var d;
      d = new Date();
      d.setTime(date);
      return "" + (d.getFullYear()) + "/" + (d.getMonth() + 1) + "/" + (d.getDate()) + " " + (d.getHours()) + ":" + (d.getMinutes()) + ":" + (d.getSeconds());
    };
    return window.app = $.sammy(function() {
      var createContent, login, showContent, signup;
      this.around(function(fn) {
        var ctx;
        ctx = this;
        (this.load("/widgets")).then(function(widgets) {
          var item, template;
          template = Handlebars.compile(navTemp);
          item = {
            navItems: [
              {
                link: 'index',
                title: 'Home'
              }, {
                link: 'ss',
                title: '硬盘'
              }, {
                dropdown: [
                  {
                    link: 's1',
                    title: '服务1'
                  }, {
                    link: 'fff',
                    title: '服务2'
                  }
                ],
                link: '#',
                title: '服务'
              }
            ]
          };
          return subnav.html(template(item));
        }).then(fn);
      });
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
          return mainArea.html(template(item));
        });
      };
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
