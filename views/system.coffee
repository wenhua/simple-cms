a '#add-widget', href: '#', -> '新建小部件'

h4 '用户列表：'
div '.row', ->
  div '.span8', ->
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
              a '.del-user', id: user.id, href: '#', -> '删除'

div '#widget-form.modal.hide.fade', ->
  form '#widget-f.form-horizontal', method: 'post', action: '#', ->
    fieldset ->
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
      div '.form-actions', ->
        input '.btn.btn-primary', type: 'submit', value: '保存'







script src: '/javascripts/system.js'
