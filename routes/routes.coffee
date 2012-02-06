nohm = (require 'nohm').Nohm
userModel = require '../model/userModel'
redis = (require 'redis').createClient()
nohm.setClient redis
nohm.setPrefix('cms-001')

exports.index =  (req, res) ->
  res.render 'index',
    user: req.user
    sitename: '我的小站'

exports.session = (req, res) ->
  res.redirect '/'

exports.logout = (req, res) ->
  req.logout()
  res.redirect('/')

exports.newUser = (req, res) ->
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
#      user.remove (err) ->
#        if err console.log err
#        else console.log 'successfully removed user'
      res.json
        result: 'success'
        data: user.allProperties()

