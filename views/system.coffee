h2 '主页'
h4 '用户列表：'
ul ->
  for user in @users
    li ->
      user.username




#script src: 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'
#script src: '/javascripts/home.js'
