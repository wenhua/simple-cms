old = ->
  $("#signup-form > form").submit ->
    $.post '/users', {
      username: $("#username").val()
      password: $("#password").val()
      email: $("#email").val()
      firstName: $("#firstName").val()
      lastName: $("#lastName").val()
    }, (data) ->
      $("#signup-form").modal 'hide'
      alert '对不起，注册用户出错，请稍后再试！' if 'success' != data.result
    no

do ->
  $ = jQuery

  ### elements ###
  loginForm = $('#login-form')
  signupForm = $('#signup-form')


  window.app = $.sammy ->
    index = (ctx) ->
      ctx.log "index loaded"

    createContent = (ctx) ->
      ctx.log "#{@} crrrrrrrrrrr"

    login = (ctx) ->
      loginForm.modal()

    signup = (ctx) ->
      signupForm.modal()

    @get '/#/', index
    @get '/#/new', createContent
    @get '/#/login', login
    @get '/#/signup', signup




$ ->
  app.run('#/')
  old()