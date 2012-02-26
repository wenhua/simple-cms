editWidgetTable = ->
#  editFields = $('#widget-list > tbody > tr .editable')
  editFields = $('body')
#  editFields.on 'click', '#widget-list > tbody > tr .editable', ->
#    td = $(@)
#    oldText = td.text()
#    textArea ="
#      <textarea rows='6' cols='120'>#{oldText}</textarea>
#      <p><a href='#'>修改</a>&nbsp;&nbsp;&nbsp;<a class='edit-cancel' href='#'>取消</a></p>
#      "
#    input = $(textArea)
#    (td.html input).click ->
#      no
#    (input.css "border-width","0").css "width","500px"
#    (input.find ".edit-cancel").click ->
#      td.html oldText
  editFields.on 'mouseover', '#widget-list > tbody > tr .editable', -> ($(@).find 'a').show()
  editFields.on 'mouseout', '#widget-list > tbody > tr .editable', -> ($(@).find 'a').hide()
  editFields.on 'click', '#widget-list > tbody > tr .editable .update-widget', ->
    td = $(@).parent()
    $(@).html ''

    oldText = td.text()
    console.log oldText

#    oldText = td.text()
#    textArea ="
#      <textarea rows='6' cols='120'>#{oldText}</textarea>
#      <p><a href='#'>修改</a>&nbsp;&nbsp;&nbsp;<a class='edit-cancel' href='#'>取消</a></p>
#      "
#    input = $(textArea)
#    (td.html input).click ->
#      no
#    (input.css "border-width","0").css "width","500px"
#    (input.find ".edit-cancel").click ->
#      td.html oldText




do ->
  $ = jQuery
  ### elements ###
  mainList = $('#main-list')
  widgetForm = $('#widget-form')
  ###  ###
  index = ->
#    mainList.html 'dfgdfgdfg'

  parseDate = (date) ->
    d = new Date()
    d.setTime date
    "#{d.getFullYear()}/#{d.getMonth()+1}/#{d.getDate()} #{d.getHours()}:#{d.getMinutes()}:#{d.getSeconds()}"

  widgetsTemp = "
    <h4>小部件列表</h4>
    <table id='widget-list' class='table table-striped'>
        <thead>
          <tr>
              <th>名称</th>
              <th>数据</th>
              <th>模板</th>
              <th>创建时间</th>
              <th>更新时间</th>
              <th>操作</th>
          </tr>
        </thead>
        <tbody>
          {{#widgets}}
          <tr>
              <td><a href='#/widgets/{{id}}'>{{name}}</a></td>
              <td class='editable'>{{data}}<a class='hide update-widget' href='#'>修改</a></td>
              <td class='editable'>{{template}}<a class='hide update-widget' href='#'>修改</a></td>
              <td>{{createDate}}</td>
              <td>{{updateDate}}</td>
              <td><a href='/widgets/{{id}}/delete'>删除</a></td>
          </tr>
          {{/widgets}}
        </tbody>
    </table>"

  contentsTemp = "
    <h4>内容页列表</h4>
    <table id='content-list' class='table table-striped'>
        <thead>
        <tr>
            <th>页面</th>
            <th>创建时间</th>
            <th>更新时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
          {{#contents}}
          <tr>
              <td><a href='/#/{{link}}'>{{title}}</a></td>
              <td>{{createTime}}</td>
              <td>{{updateTime}}</td>
              <td><a href='/{{id}}/delete'>删除</a></td>
          </tr>
          {{/contents}}
        </tbody>
    </table>"

  window.app = $.sammy ->

    listWidgets = ->
      (@load '/widgets').then (items) ->
        template = Handlebars.compile(widgetsTemp)
        mainList.html template $.parseJSON items

    createWidget = (ctx) ->
      widgetForm.modal()

    listContent = (ctx) ->
      (@load '/contents').then (i) ->
        items = $.parseJSON i
        (_ items.contents).map (obj) ->
          obj.createTime = parseDate obj.createTime
          obj.updateTime = parseDate obj.updateTime
        source = contentsTemp
        template = Handlebars.compile(source)
        mainList.html template items

    @get '#/widgets', listWidgets
    @get '#/widgets/new', createWidget
    @get '#/contents', listContent

$ ->
  editWidgetTable()
  app.run('#/')