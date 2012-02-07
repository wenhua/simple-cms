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
  attributes = (_ req.body).clone()
  id = attributes.id
  delete attributes.id
  console.log "#{req.length} 11111111"
  for p in req
    console.log p



  res.send attributes

_.extend exports,
  createWidget: updateWidget
  index: index
