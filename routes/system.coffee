nohm = (require 'nohm').Nohm
models = require '../model/models'
redis = (require 'redis').createClient()
nohm.setClient redis
nohm.setPrefix('cms-001')
_ = require 'underscore'

parseUser = (user) -> {
    id: user.id
    username: user.username
    fullName: "#{user.firstName}#{user.lastName}"
    email: user.email
  }

index =  (req, res) ->
  objs = []
  (new models.User).find (err, ids) ->
    if err
      console.log err; res.send 500
    else
      pass = _.after ids.length, ->
        res.render 'system',
          user: req.user
          users: (_ objs).map parseUser
          sitename: '我的小站'
      _.each ids, (id) ->
        user = new models.User
        user.load id, (err, props) ->
          if err
            console.log err; res.send 500
          else
            attributes = JSON.parse user.allProperties true
            objs.push attributes
          pass()

destroyUser = (req, res) ->
  id = req.params.id
  user = new models.User
  user.load id, (err, props) ->
    if err
      console.log "no find #{err}"
      res.send 500
    else
      user.remove (err) ->
        if not err
          res.redirect "/system"
        else
          console.log "delete unsuccess #{err}"
          res.send 500
destroyWidget = (req, res) ->
  id = req.params.id
  widget = new models.Widget
  widget.load id, (err, props) ->
    if err
      console.log "no find #{err}"
      res.send 500
    else
      widget.remove (err) ->
        if not err
          res.redirect "/system#/widgets"
        else
          console.log "delete unsuccess #{err}"
          res.send 500

listWidgets =  (req, res) ->
  objs = []
  (new models.Widget).find (err, ids) ->
    if err
      console.log err; res.send 500
    else
      pass = _.after ids.length, ->
        res.json
          widgets: (_ objs).map (obj) ->{
            id: obj.id
            name: obj.name
            data: obj.data
            template: obj.template
          }
      _.each ids, (id) ->
        widget = new models.Widget
        widget.load id, (err, props) ->
          if err
            console.log err; res.send 500
          else
            attributes = JSON.parse widget.allProperties true
            objs.push attributes
          pass()

createWidget = (req, res) ->
  _CREATE = 0
  _UPDATE = 1
  attributes = (_ req.body).clone()
  id = attributes.widgetId
  action = if id is attributes.id then _UPDATE else _CREATE
  now = (new Date()).getTime()
  attributes.createTime = now if action is _CREATE
  attributes.updateTime = now
  delete attributes.id
  widget = nohm.factory 'Widget'

  widget.p attributes
  widget.save  (err) ->
    if not err
      res.redirect "/system#/widgets"
    else if err is 'invalid'
      res.json err: '输入数据不符合规范，请检查'
    else
      console.log "#{err} widget save error!!!!"
      res.send 500

updateWidget = (req, res) ->
  console.log req.body
#  attributes = (_ req.body).clone()

  id = req.params.id
  now = (new Date()).getTime()
  attributes.updateTime = now
  console.dir attributes
  widget = new models.Widget
  widget.load id, (err, props) ->
    if err
      console.log "update widget no find #{err}"
      res.send 500
    else
      widget.p attributes
  #    widget.remove (err) ->
  #      if not err
  #        res.redirect "/system#/widgets"
  #      else
  #        console.log "delete unsuccess #{err}"
  #        res.send 500
      console.log  widget.allProperties
      res.json err: '输入数据不符合规范，请检查'


#
#  widget.save  (err) ->
#    if not err
#      res.redirect "/system#/widgets"
#    else if err is 'invalid'
#      res.json err: '输入数据不符合规范，请检查'
#    else
#      console.log "#{err} widget save error!!!!"
#      res.send 500

_.extend exports,
  listWidgets: listWidgets
  createWidget: createWidget
  updateWidget: updateWidget
  index: index
  destroyUser: destroyUser
  destroyWidget: destroyWidget
