doctype 5
html ->
  head ->
    meta charset: 'utf-8'
    title= "#{@title or '网页'}"
    link rel: 'stylesheet', href: '/stylesheets/style.css'
    link rel: 'stylesheet', href: '/vendor/bootstrap.min.2.0.0.css'
    script src: '/vendor/jquery-1.7.1.min.js'
    script src: '/vendor/bootstrap.min.2.0.0.js'
    script src: '/javascripts/common.js'
  body ->
    div '.navbar.navbar-fixed-top', ->
      div '.navbar-inner', ->
        div '.container-fluid', ->
          a '.brand', href: '/' , -> "#{@sitename or '无名小站'}"
          div '.nav-collapse', ->
            ul '.nav', ->
              li '.active', ->
                a href: '/' , ->
                  i class: 'icon-home icon-white'
                  "首页"
            p '#nav-r-o.navbar-text.pull-right', ->
              if @user
                  text "你好：#{@user.username} &nbsp;
                  #{yield -> a href: '/logout', '登出'} &nbsp;
                  #{yield -> a href: '/system', '系统'} &nbsp;
                  #{yield -> a '#admin-o', href: '#', '管理'}
                  #{yield -> a '#admin-o-e', href: '#' , '退出管理'}"
              else
                  a '#login-o.btn.btn-small.btn-primary', href: '#login' , -> '登录'
                  a '#sigup.btn.btn-small.btn-primary', href: '#signup-form' , -> '注册'
    div '.container-fluid', ->
      div '.row-fluid', ->
        @body

