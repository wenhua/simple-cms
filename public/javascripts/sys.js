(function() {

  (function() {
    var $, index, mainList, widgetsTemp;
    $ = jQuery;
    /* elements
    */
    mainList = $('#main-list');
    /*
    */
    index = function() {};
    widgetsTemp = "    <h4>小部件列表</h4>    <ul id='widget-list'>      {{#widgets}}          <li>{{name}}-{{data}}-{{template}}</li>      {{/widgets}}    </ul>  ";
    return window.app = $.sammy(function() {
      var listWidgets;
      listWidgets = function() {
        return (this.load('/widgets')).then(function(items) {
          var source, template;
          source = widgetsTemp;
          template = Handlebars.compile(source);
          return mainList.html(template($.parseJSON(items)));
        });
      };
      this.get('#/', index);
      return this.get('#/widgets', listWidgets);
    });
  })();

  $(function() {
    return app.run('#/');
  });

}).call(this);
