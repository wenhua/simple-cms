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
  mainArea = $('#main-area')
  up = $('#up')
  subnav = $('#subnav')

  contentTemp = "
    <h4>{{title}}</h4>
    <p>{{createTime}}</p>
    <p>{{updateTime}}</p>
    <p><a href='/#/users/{{createUserId}}'>{{createUserName}}</a></p>"

  navTemp = "
    <ul class='nav nav-pills'>
        {{#navItems}}
        <li><a href='/#/{{link}}'>{{title}}</a></li>
        {{#navItems}}
        <li><a href='/system'>系统</a></li>
    </ul>"

  parseDate = (date) ->
    d = new Date()
    d.setTime date
    "#{d.getFullYear()}/#{d.getMonth()+1}/#{d.getDate()} #{d.getHours()}:#{d.getMinutes()}:#{d.getSeconds()}"

  window.app = $.sammy ->
    @around (fn) ->
      ctx = @
      console.log "#{@} dddddddddddd"

    #      source = navTemp
#      template = Handlebars.compile(source)
#      item =
#        navItems: [{
#          link: 'index'
#          title: 'Home'
#
#        }]
#      subnav.append template item
      (@load "/widgets")
        .then (widgets) ->
          console.log "#{@}"
        .then fn
      return
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
        mainArea.html template item

#    @get '/#/', index
#    @get '/#/:link/delete', destroyContent
    @get '/#/new', createContent
    @get '/#/login', login
    @get '/#/signup', signup
    @get '/#/:link', showContent

$ ->
  app.run('#/index')
  old()