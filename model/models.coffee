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
    lastName:
      type: 'string'
    profile:
      type: 'json'
  methods:
    fullName: ->
      "#{@p 'firstName'}#{@p 'lastName'}"

Widget = nhom.model 'Widget',
  properties:
    name:
      type: 'string'
      unique: yes
      index: yes
      validations: ['notEmpty']
    data:
      type: 'string'
    template:
      type: 'string'
    createTime:
      type: 'timestamp'
      defaultValue: -> new Date()
    updateTime:
      type: 'timestamp'
      defaultValue: -> new Date()
    profile:
      type: 'json'


_.extend exports,
  User: User
  Widget: Widget

