div '.span3', ->
  div '.well.sidebar-nav', ->
    ul '.nav.nav-list', ->
      li '.nav-header', -> '用户管理'
      li -> a '#list-user', href: '#/users', -> '用户列表'
      li '.nav-header', -> '小部件管理'
      li -> a '#add-widget.active', href: '#add-widget', -> '新建小部件'
      li -> a '#list-widget', href: '#/widgets', -> '小部件列表'

div '.span9', ->
  div '#main-list', ->
  div '#userList', ->
    h4 '用户列表：'
    table '.table.table-striped', ->
      thead ->
        tr ->
          th '用户'
          th '电子邮件'
          th '操作'
      tbody ->
        for user in @users
          tr ->
            td ->
              a id: user.id, href: '#', -> user.fullName
            td ->
              user.email
            td ->
              a '.del-user', id: user.id, href: "/users/#{user.id}/delete", -> '删除'

div '#widget-form.modal.hide.fade', ->
  form '#widget-f.form-horizontal', method: 'post', action: '#', ->
    fieldset ->
      input '#f-widget-id', type: 'hidden', name: 'widget', value: @widget.id if @widget?
      legend '添加小部件'
      div '.control-group', ->
        label '.control-label', for: 'widget-name', -> '名称'
        div '.controls', ->
          input '#widget-name.input-xlarge', type: 'text', name: 'name', placeholder: '名称', required: true
      div '.control-group', ->
        label '.control-label', for: 'widget-temp', -> '模板'
        div '.controls'         , ->
          textarea '#widget-temp.input-xxlarge', rows: '8', name: 'temp', placeholder: '模板', required: true
      div '.control-group', ->
        label '.control-label', for: 'widget-data', -> '数据'
        div '.controls', ->
          textarea '#widget-data.input-xxlarge', rows: '6', name: 'data', placeholder: '数据', required: true
    div 'modal-footer', ->
      input '.btn.btn-primary', type: 'submit', value: '保存'
      a '.btn.', href: '/system', -> '取消'







script src: '/javascripts/sys.js'
