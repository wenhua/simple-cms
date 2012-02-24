(function() {

  (function() {
    var $, contentsTemp, index, mainList, parseDate, widgetForm, widgetsTemp;
    $ = jQuery;
    /* elements
    */
    mainList = $('#main-list');
    widgetForm = $('#widget-form');
    /*
    */
    index = function() {};
    parseDate = function(date) {
      var d;
      d = new Date();
      d.setTime(date);
      return "" + (d.getFullYear()) + "/" + (d.getMonth() + 1) + "/" + (d.getDate()) + " " + (d.getHours()) + ":" + (d.getMinutes()) + ":" + (d.getSeconds());
    };
    widgetsTemp = "    <h4>小部件列表</h4>    <table id='widget-list' class='table table-striped'>        <thead>          <tr>              <th>名称</th>              <th>数据</th>              <th>模板</th>              <th>创建时间</th>              <th>更新时间</th>              <th>操作</th>          </tr>        </thead>        <tbody>          {{#widgets}}          <tr>              <td><a href='#/widgets/{{id}}'>{{name}}</a></td>              <td>{{data}}</td>              <td>{{template}}</td>              <td>{{createDate}}</td>              <td>{{updateDate}}</td>              <td><a href='/widgets/{{id}}/delete'>删除</a></td>          </tr>          {{/widgets}}        </tbody>    </table>";
    contentsTemp = "    <h4>内容页列表</h4>    <table id='content-list' class='table table-striped'>        <thead>        <tr>            <th>页面</th>            <th>创建时间</th>            <th>更新时间</th>            <th>操作</th>        </tr>        </thead>        <tbody>          {{#contents}}          <tr>              <td><a href='/#/{{link}}'>{{title}}</a></td>              <td>{{createTime}}</td>              <td>{{updateTime}}</td>              <td><a href='/{{id}}/delete'>删除</a></td>          </tr>          {{/contents}}        </tbody>    </table>";
    return window.app = $.sammy(function() {
      var createWidget, listContent, listWidgets;
      listWidgets = function() {
        return (this.load('/widgets')).then(function(items) {
          var template;
          template = Handlebars.compile(widgetsTemp);
          return mainList.html(template($.parseJSON(items)));
        });
      };
      createWidget = function(ctx) {
        return widgetForm.modal();
      };
      listContent = function(ctx) {
        return (this.load('/contents')).then(function(i) {
          var items, source, template;
          items = $.parseJSON(i);
          (_(items.contents)).map(function(obj) {
            obj.createTime = parseDate(obj.createTime);
            return obj.updateTime = parseDate(obj.updateTime);
          });
          source = contentsTemp;
          template = Handlebars.compile(source);
          return mainList.html(template(items));
        });
      };
      this.get('#/widgets', listWidgets);
      this.get('#/widgets/new', createWidget);
      return this.get('#/contents', listContent);
    });
  })();

  $(function() {
    return app.run('#/');
  });

}).call(this);
