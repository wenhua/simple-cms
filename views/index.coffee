div '#main-list', ->
div '#main-area', ->


div "#signup-form.modal.hide.fade", ->
  form '.form-horizontal', method: 'post', action: '/users', ->
    fieldset ->
      legend '注册新用户'
      div '.control-group', ->
        label '.control-label', for: 'username', -> '登录名'
        div '.controls', ->
          input type: 'text', id: 'username', name: 'username', placeholder: '登录名', required: yes
      div '.control-group', ->
        label '.control-label', for: 'password', -> '密码'
        div '.controls', ->
          input type: 'password', id: 'password', name: 'password', placeholder: '密码', required: yes
      div '.control-group', ->
        label '.control-label', for: 'password', -> '重复密码'
        div '.controls', ->
          input type: 'password', id: 'rePassword', name: 'rePassword', placeholder: '重复密码', required: yes
      div '.control-group', ->
        label '.control-label', for: 'email', -> '电子邮件'
        div '.controls', ->
          input type: 'text', name: 'email', id: 'email', placeholder: '电子邮件', required: yes
      div '.control-group', ->
        label '.control-label', for: 'firstName', -> '姓'
        div '.controls', ->
          input type: 'text', name: 'firstName', id: 'firstName', placeholder: '姓', required: yes
      div '.control-group', ->
        label '.control-label', for: 'lastName', -> '名'
        div '.controls', ->
          input type: 'text', name: 'lastName', id: 'lastName', placeholder: '名', required: yes
    div '.form-actions', ->
      input '.btn.btn-primary', type: 'submit', value: '注册'

div '#login-form.modal.hide.fade', ->
  form '.form-horizontal', method: 'post', action: '/sessions', ->
    fieldset ->
      legend '用户登录'
      div '.control-group', ->
        label '.control-label', for: 'username', -> '用户名'
        div '.controls', ->
          input '.input-xlarge', type: 'text', name: 'username', id: 'username', placeholder: '用户名', required: true
          p '.help-block', '请输入注册时的用户名或email地址'
      div '.control-group', ->
        label '.control-label', for: 'password', -> '密码'
        div '.controls', ->
          input '.input-xlarge', type: 'password', id: 'password', name: 'password', placeholder: '密码', required: true
      div '.form-actions', ->
        input '.btn.btn-primary', type: 'submit', value: '登入'

div '#content-form.modal.hide.fade', ->
  form '.form-horizontal', method: 'post', action: '/contents', ->
    fieldset ->
      legend '新建页面'
      div '.control-group', ->
        label '.control-label', for: 'title', -> '标题'
        div '.controls', ->
          input '.input-xxlarge', type: 'text', name: 'title', id: 'cont-title', placeholder: '页面标题', required: true
          p '内容页的标题，可以是英文或者中文，不要超过60个字'
      div '.control-group', ->
        label '.control-label', for: 'link', -> '链接'
        div '.controls', ->
          input '.input-xxlarge', type: 'text', id: 'cont-link', name: 'link', placeholder: '请使用唯一的字母、数字和-，不要有空格，【可选】'
      div '.form-actions', ->
        input '.btn.btn-primary', type: 'submit', value: '保存'


script src: '/javascripts/ind.js'







































