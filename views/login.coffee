form method: 'post', action: '/sessions', ->
  div 'data-role': 'fieldcontain', ->
    label for: 'username', -> '用户名'
    p ->
      input type: 'text', name: 'username', id: 'username', placeholder: '用户名', required: true
  div 'data-role': 'fieldcontain', ->
    label for: 'password', -> '密码'
    p ->
      input type: 'password', id: 'password', name: 'password', placeholder: '密码', required: true
#    label for: 'password_confirmation', -> 'Password Confirmation'
#    input type: 'password', id: 'password_confirmation', name: 'password_confirmation', placeholder: 'password confirmation'
  div 'data-role': 'fieldcontain', ->
    input type: 'submit', value: '登入'
