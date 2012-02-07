nhom = (require 'nohm').Nohm
redis = (require 'redis').createClient()
_ = require 'underscore'
nhom.setClient redis

User = nhom.model 'User',
  properties:
    username:
      type: 'string'
      unique: yes
      index: yes
      validations: ['notEmpty']
    email:
      type: 'string'
      unique: yes
      defaultValue: 'none@none.com'
      validations: ['email']
    password:
      type: 'string'
      validations: ['notEmpty']
    firstName:
      type: 'string'
      unique: no
    lastName:
      type: 'string'
      unique: no
    profile:
      type: 'json'
  methods:
    fullName: ->
      "#{@p 'firstName'}#{@p 'lastName'}"
    store: (data, callback) ->
      self = @
      @save ->
        delete self.errors.salt;
        callback.apply self, Array.prototype.slice.call arguments, 0
_.extend exports,
  User: User

