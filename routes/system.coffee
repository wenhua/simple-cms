nohm = (require 'nohm').Nohm
userModel = require '../model/userModel'
redis = (require 'redis').createClient()
nohm.setClient redis
nohm.setPrefix('cms-001')

exports.system =  (req, res) ->
  userModel.find (err, ids) ->
    if err then console.log err; return null
    users = []
    count = 0
    len = ids.length

    for id in ids
      user = new userModel()
      user.load id, (err, props) ->
        if err then co err
        users.push
          id: @id
          #          username: props.username
          username: props.firstName
        if ++count is len
          res.render 'system',
            users: users
            user: req.user
