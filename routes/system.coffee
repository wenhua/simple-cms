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
      _.each ids, (id) ->
        user = new models.User
        user.load id, (err, props) ->
          if err
            console.log err; res.send 500
          else
            attributes = JSON.parse user.allProperties true
            objs.push attributes
          pass()

updateWidget = (req, res) ->
  _CREATE = 0
  _UPDATE = 1
  attributes = (_ req.body).clone()
  id = attributes.widgetId
  action = if id is attributes.id then _UPDATE else _CREATE
  now = (new Date()).getTime()
  attributes.createTime = now if action is _CREATE
  attributes.updateTime = now
  delete attributes.id
  widget = if action is _CREATE then nohm.factory 'Widget' else new models.Widget id

  widget.p attributes
  widget.save  (err) ->
    if not err
      res.json
        result: true
        data: widget.allProperties()
    else if err is 'invalid'
      res.json err: '输入数据不符合规范，请检查'
    else
      console.log "#{err} widget save error!!!!"
      res.send 500

_.extend exports,
  createWidget: updateWidget
  index: index
