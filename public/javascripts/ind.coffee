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
          {{#if dropdown}}
              <li class='dropdown'><a class='dropdown-toggle' data-toggle='dropdown' href='{{link}}'n>{{title}}<b class='caret'></b></a>
                <ul class='dropdown-menu'>
                    {{#dropdown}}
                    <li><a href='/#/{{link}}'>{{title}}</a></li>
                    {{/dropdown}}
                </ul>
              </li>
          {{else}}
              <li><a href='/#/{{link}}'>{{title}}</a></li>
          {{/if}}
        {{/navItems}}
        <li><a href='/system'>系统</a></li>
    </ul>"

  parseDate = (date) ->
    d = new Date()
    d.setTime date
    "#{d.getFullYear()}/#{d.getMonth()+1}/#{d.getDate()} #{d.getHours()}:#{d.getMinutes()}:#{d.getSeconds()}"

  window.app = $.sammy ->
    @around (fn) ->
      ctx = @
      (@load "/widgets")
        .then (widgets) ->
          template = Handlebars.compile(navTemp)
          item =
            navItems: [{
              link: 'index'
              title: 'Home'
            },
            {
              link: 'ss'
              title: '硬盘'
            },
            {
              dropdown: [{
                link: 's1'
                title: '服务1'
              }, {
                link: 'fff'
                title: '服务2'
              }
              ]
              link: '#'
              title: '服务'
            }]
          subnav.html template item
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