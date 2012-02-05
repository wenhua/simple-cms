form method: 'post', action: '/users', ->
  fieldset ->
    legend '注册新用户'
    div 'data-role': 'fieldcontain', ->
      label for: 'username', -> '登录名'
      p ->
        input type: 'text', id: 'username', name: 'username', placeholder: '登录名', required: yes
    div 'data-role': 'fieldcontain', ->
      label for: 'password', -> '密码'
      p ->
        input type: 'password', id: 'password', name: 'password', placeholder: '密码', required: yes
      p ->
        input type: 'password', id: 'rePassword_confirmation', name: 'rePassword', placeholder: '重复密码', required: yes
    div 'data-role': 'fieldcontain', ->
      label for: 'email', -> '电子邮件'
      p ->
        input type: 'text', name: 'email', id: 'email', placeholder: '电子邮件', required: yes
      label for: 'firstName', -> '姓'
      p ->
        input type: 'text', name: 'firstName', id: 'firstName', placeholder: '姓', required: yes
      label for: 'lastName', -> '名'
      p ->
        input type: 'text', name: 'lastName', id: 'lastName', placeholder: '名', required: yes
  div 'data-role': 'fieldcontain', ->
    input type: 'submit', value: '注册'


script src: '/javascripts/index.js'
