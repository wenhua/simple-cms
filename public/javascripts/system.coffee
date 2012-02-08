class Widget extends Spine.Model
  @configure 'Widget', 'widgetId', 'name', 'data', 'template'
  @extend Spine.Model.Ajax
  @url: "/widgets"

class WidgetCtrl extends Spine.Controller
  events:
    'click #add-widget': 'add'
    'submit form': 'create'
  elements:
    "#widget-f": "form"
    "#widget-form": "formDiv"
    "#widget-name": "name"
    "#widget-temp": "template"
    "#widget-data": "data"
    "#f-widget-id": "widgetId"
  add: ->
    $("#widget-form").modal()
  create: (e) ->
    e.preventDefault()
    widget = new Widget
      widgetId: @widgetId.val()
      name: @name.val()
      template: @template.val()
      data: @data.val()
    widget.bind "ajaxSuccess", (status, xhr) =>
      @formDiv.modal 'hide'
    widget.bind "ajaxError", (record, xhr, settings, error) ->
      alert "对不起，新建Widget出错，请稍后再试！ #{record} #{xhr} #{settings} #{error}"
    widget.save()
$ ->
  new WidgetCtrl el: $("#up")


