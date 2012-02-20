nohm = (require 'nohm').Nohm
models = require '../model/models'
redis = (require 'redis').createClient()
nohm.setClient redis
nohm.setPrefix('cms-001')
_ = require 'underscore'

index =  (req, res) ->
  res.render 'index',
    user: req.user
    sitename: '我的小站'

session = (req, res) ->
  res.redirect '/'

logout = (req, res) ->
  req.logout()
  res.redirect('/')

createUser = (req, res) ->
  user = nohm.factory 'User'
  user.p
    username: req.param 'username'
    password: req.param 'password'
    email: req.param 'email'
    firstName: req.param 'firstName'
    lastName: req.param 'lastName'
  user.save  (err) ->
    if err is 'invalid'
      console.log 'properties were invalid: ', user.errors
      res.json
        result: 'err'
    else if err
      console.log err
      res.json
        result: 'err'
    else
      res.json
        result: 'success'
        data: user.allProperties()

createContent = (req, res) ->
  attributes = (_ req.body).clone()
  now = (new Date()).getTime()
  attributes.createTime = now
  attributes.updateTime = now
  delete attributes.id
  content = nohm.factory 'Content'

  user = new models.User
  user.load req.user.id, (err, props) ->
    if err
      no

  content.p attributes
  content.link user, 'createdBy'
  content.save  (err) ->
    if not err
      if attributes.link is ''
        attributes.link = content.id
        content.p attributes
        content.save (err) ->
          if err then res.send 500
      res.redirect("/#/#{attributes.link}")
#      res.json
#        result: true
#        data: content.allProperties()
    else if err is 'invalid'
      res.json err: '输入数据不符合规范，请检查'
    else
      console.log "#{err} content save error!!!!"
      res.send 500

listContent = (req, res) ->
  objs = []
  (new models.Content).find (err, ids) ->
    if err
      console.log err
      res.send 500
    else
      pass = _.after ids.length, ->
        res.json
          contents: (_ objs).map (obj) ->{
            id: obj.id
            link: obj.link
            title: obj.title
            createTime: obj.createTime
            updateTime: obj.updateTime
          }
      _.each ids, (id) ->
        content = new models.Content
        content.load id, (err, props) ->
          if err
            console.log err; res.send 500
          else
            attributes = JSON.parse content.allProperties true
            objs.push attributes
          pass()

showContent = (req, res) ->
  (new models.Content).find {link: req.params.link}, (err, ids) ->
    if err
      console.log err; res.send 500
    else
      content = new models.Content
      content.load ids[0], (err, props) ->
        if err
          console.log err; res.send 500
        else
          attributes = JSON.parse content.allProperties true
          content.getAll 'User', 'createdBy', (err, cIds) ->
            user = new models.User
            user.load cIds[0], (err, props) ->
              if err
                no
              else
                attributes.createUserId = cIds[0]
                attributes.createUserName = "#{props.firstName}#{props.lastName}"
                console.dir attributes
                res.json attributes

destroyContent = (req, res) ->
  id = req.params.id
  content = new models.Content
  content.load id, (err, props) ->
    if err
      console.log "no find #{err}"
      res.send 500
    else
      content.remove (err) ->
        if not err
          res.redirect "/"
        else
          console.log "delete unsuccess #{err}"
          res.send 500

_.extend exports,
  listContent: listContent
  createContent: createContent
  createUser: createUser
  logout: logout
  session: session
  index: index
  showContent: showContent
  destroyContent: destroyContent



