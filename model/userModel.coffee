nhom = (require 'nohm').Nohm
redis = (require 'redis').createClient()
nhom.setClient redis

module.exports = nhom.model 'User',
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
#      @fill data
      @save ->
        delete self.errors.salt;
        callback.apply self, Array.prototype.slice.call arguments, 0

