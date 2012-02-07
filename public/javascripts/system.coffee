class Widget extends Spine.Model
  @configure 'Widget', 'name', 'data', 'template'
  @extend Spine.Model.Ajax
  @url: "/widgets"

class WidgetCtrl extends Spine.Controller
  events:
    'click #add-widget': 'add'
    'submit form': 'create'
  elements:
    "#widget-f": "form"
    "#widget-name": "name"
    "#widget-temp": "template"
    "#widget-data": "data"
  add: ->
    $("#widget-form").modal()
  create: (e) ->
    e.preventDefault()
    widget = new Widget
      name: @name.val()
      template: @template.val()
      data: @data.val()
    widget.save()

$ ->
  new WidgetCtrl el: $("#up")


