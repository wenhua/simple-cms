#Page = App.Page

class Widget extends Spine.Model
  @configure 'Widget', 'widgetId', 'name', 'data', 'template'
  @extend Spine.Model.Ajax
  @url: "/widgets"


class Index extends Spine.Controller
  constructor: ->
    @routes
      "add-widget": ->
        new NewWidget el: $("#up")
      "widgets": ->
        new WidgetsList el: $("#main-list")

class NewWidget extends Spine.Controller
  constructor: ->
    super
    $("#widget-form").modal backdrop: false
  events:
    'submit form': 'create'
  elements:
    "#widget-f": "form"
    "#widget-form": "formDiv"
  create: (e) ->
    e.preventDefault()
    widget = Widget.fromForm(e.target).save()
    widget.bind "ajaxSuccess", (status, xhr) =>
      @formDiv.modal 'hide'
      e.target.reset()
    widget.bind "ajaxError", (record, xhr, settings, error) ->
      alert "对不起，新建Widget出错，请稍后再试！ #{record} #{xhr} #{settings} #{error}"
    @navigate ''

class WidgetsList extends Spine.Controller
  elements:
    "#main-list": "mainList"
  constructor: ->
    super
    Widget.fetch()
    @render()
  render: =>
    widgets = Widget.all()
#    console.log widgets
#    @mainList.html "widgetspp"
    console.log(widget.name) for widget in widgets
    @html "123p #{widgets}"
$ ->
  new Index el: $("#up")
  Spine.Route.setup()


