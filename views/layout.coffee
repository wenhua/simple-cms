doctype 5
html ->
  head ->
    meta charset: 'utf-8'
    title= @title
    link rel: 'stylesheet', href: '/stylesheets/style.css'
    script src: '/vendor/jquery-1.7.1.min.js'
    script src: '/javascripts/common.js'
  body ->
    header ->
      div ->
        a href: '/' , -> '返回首页'
      if @user
        div ->
            text "你好：#{@user.username} &nbsp;
            #{yield -> a href: '/logout', '登出'} &nbsp;
            #{yield -> a href: '/system', '系统'} &nbsp;
            #{yield -> a '#admin-o', href: '#', '管理'}
            #{yield -> a '#admin-o-e', href: '#' , '退出管理'}"
      else
        p ->
          a href: '/login' , -> '登录'
    @body

