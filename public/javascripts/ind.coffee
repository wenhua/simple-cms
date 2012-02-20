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
  contencForm = $('#content-form')
  mainList = $('#main-list')
  up = $('#up')

  contentTemp = "
    <h4>{{title}}</h4>
    <p>{{createTime}}</p>
    <p>{{updateTime}}</p>
    <p><a href='/#/users/{{createUserId}}'>{{createUserName}}</a></p>"

  parseDate = (date) ->
    d = new Date()
    d.setTime date
    "#{d.getFullYear()}/#{d.getMonth()+1}/#{d.getDate()} #{d.getHours()}:#{d.getMinutes()}:#{d.getSeconds()}"

  window.app = $.sammy ->
    index = (ctx) ->
      yes

    createContent = (ctx) ->
      contencForm.modal()

    login = (ctx) ->
      loginForm.modal()

    signup = (ctx) ->
      signupForm.modal()

    showContent = (ctx)->
      (@load "/#{@params['link']}").then (i) ->
        item = $.parseJSON i
        item.createTime = parseDate item.createTime
        item.updateTime = parseDate item.updateTime
        source = contentTemp
        template = Handlebars.compile(source)
        up.append template item

    @get '/#/', index
#    @get '/#/:link/delete', destroyContent
    @get '/#/new', createContent
    @get '/#/login', login
    @get '/#/signup', signup
    @get '/#/:link', showContent

$ ->
  app.run('#/index')
  old()