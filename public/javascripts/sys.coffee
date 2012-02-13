do ->
  $ = jQuery
  ### elements ###
  mainList = $('#main-list')
  ###  ###
  index = ->
#    mainList.html 'dfgdfgdfg'

  widgetsTemp = "
    <h4>小部件列表</h4>
    <ul id='widget-list'>
      {{#widgets}}
          <li>{{name}}-{{data}}-{{template}}</li>
      {{/widgets}}
    </ul>
  "

#this.name = this.params.name;
#// render the template and pass it through handlebars
#this.partial('mytemplate.hb');



  window.app = $.sammy ->


    listWidgets = ->
      (@load '/widgets').then (items) ->

        source = widgetsTemp
        template = Handlebars.compile(source)
        mainList.html template $.parseJSON items

#        console.log widgetsTemp
#        console.log items
#        template = Handlebars.compile widgetsTemp
#        mainList.html template items
#
#
#
#        @widgets = items
#        mainList.html @partial 'widgetsTemp'

    @get '#/', index
    @get '#/widgets', listWidgets




























$ ->
  app.run('#/')