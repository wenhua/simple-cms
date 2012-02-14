(function() {

  (function() {
    var $, loginForm, signupForm;
    $ = jQuery;
    /* elements
    */
    loginForm = $('#login-form');
    signupForm = $('#signup-form');
    return window.app = $.sammy(function() {
      var createContent, index, login, signup;
      index = function(ctx) {
        return ctx.log("index loaded");
      };
      createContent = function(ctx) {
        return ctx.log("" + this + " crrrrrrrrrrr");
      };
      login = function(ctx) {
        return loginForm.modal();
      };
      signup = function(ctx) {
        return signupForm.modal();
      };
      this.get('/#/', index);
      this.get('/#/new', createContent);
      this.get('/#/login', login);
      return this.get('/#/signup', signup);
    });
  })();

  $(function() {
    return app.run('#/');
  });

}).call(this);
