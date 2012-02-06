section ->
  h4 '用户列表：'
  div '.row', ->
    div '.span8', ->
      table '.table.table-striped', ->
        thead ->
          tr ->
            th '用户信息'
        tbody ->
          for user in @users
            tr ->
              td ->
                a id: user.id, href: '#', -> user.username




#script src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'
#script src: '/javascripts/home.js'
