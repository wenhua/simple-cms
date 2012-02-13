(function() {
  var Index, NewWidget, Widget, WidgetsList,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Widget = (function(_super) {

    __extends(Widget, _super);

    function Widget() {
      Widget.__super__.constructor.apply(this, arguments);
    }

    Widget.configure('Widget', 'widgetId', 'name', 'data', 'template');

    Widget.extend(Spine.Model.Ajax);

    Widget.url = "/widgets";

    return Widget;

  })(Spine.Model);

  Index = (function(_super) {

    __extends(Index, _super);

    function Index() {
      this.routes({
        "add-widget": function() {
          return new NewWidget({
            el: $("#up")
          });
        },
        "widgets": function() {
          return new WidgetsList({
            el: $("#main-list")
          });
        }
      });
    }

    return Index;

  })(Spine.Controller);

  NewWidget = (function(_super) {

    __extends(NewWidget, _super);

    function NewWidget() {
      NewWidget.__super__.constructor.apply(this, arguments);
      $("#widget-form").modal({
        backdrop: false
      });
    }

    NewWidget.prototype.events = {
      'submit form': 'create'
    };

    NewWidget.prototype.elements = {
      "#widget-f": "form",
      "#widget-form": "formDiv"
    };

    NewWidget.prototype.create = function(e) {
      var widget,
        _this = this;
      e.preventDefault();
      widget = Widget.fromForm(e.target).save();
      widget.bind("ajaxSuccess", function(status, xhr) {
        _this.formDiv.modal('hide');
        return e.target.reset();
      });
      widget.bind("ajaxError", function(record, xhr, settings, error) {
        return alert("对不起，新建Widget出错，请稍后再试！ " + record + " " + xhr + " " + settings + " " + error);
      });
      return this.navigate('');
    };

    return NewWidget;

  })(Spine.Controller);

  WidgetsList = (function(_super) {

    __extends(WidgetsList, _super);

    WidgetsList.prototype.elements = {
      "#main-list": "mainList"
    };

    function WidgetsList() {
      this.render = __bind(this.render, this);      WidgetsList.__super__.constructor.apply(this, arguments);
      Widget.fetch();
      this.render();
    }

    WidgetsList.prototype.render = function() {
      var Widget, widgets, _i, _len;
      widgets = Widget.all();
      console.log(widgets);
      for (_i = 0, _len = widgets.length; _i < _len; _i++) {
        Widget = widgets[_i];
        console.log(Widget.name);
      }
      return this.html("123p " + widgets);
    };

    return WidgetsList;

  })(Spine.Controller);

  $(function() {
    new Index({
      el: $("#up")
    });
    return Spine.Route.setup();
  });

}).call(this);
