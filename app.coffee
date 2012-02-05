express = require 'express'
routes = require './routes'
system = require './routes/system'
passport = require 'passport'
util = require 'util'
LocalStrategy = require('passport-local').Strategy

nohm = (require 'nohm').Nohm
userModel = require './model/userModel'
redis = (require 'redis').createClient()
nohm.setClient redis
nohm.setPrefix('cms-001')

app = module.exports = express.createServer()

app.configure ->
    app.set 'views', "#{__dirname}/views"
    app.set 'view engine', 'coffee'
    app.use express.logger()
    app.use express.cookieParser()
    app.register '.coffee', require('coffeekup').adapters.express
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use require('stylus').middleware
      src: "#{__dirname}/public"
    app.use express.compiler
      src: "#{__dirname}/public"
      enable: ['coffeescript']
    app.use express.session
      secret: 'keyboard cat'
    app.use passport.initialize()
    app.use passport.session()
    app.use app.router
    app.use express.static "#{__dirname}/public"

app.configure 'development', ->
    app.use express.errorHandler
      dumpExceptions: true
      showStack: true

app.configure 'production', ->
    app.use express.errorHandler()


findById = (id, fn) ->
  user = new userModel()
  user.load id, (err, props) ->
    if err
      return fn new Error "User #{id} does not exist"
    else
      fn null, {
        id: @id
        username: props.username
        password: props.password
        email: props.email
      }

findByUsername = (username, fn) ->
  userModel.find {username: username}, (err, ids) ->
    if err
      return fn null, null
    id = ids[0]
    user = new userModel()
    user.load id, (err, props) ->
      if err
        return fn null, null
      else
        fn null, {
          id: @id
          username: props.username
          password: props.password
          email: props.email
        }

passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  findById id, (err, user) ->
    done(err, user)

passport.use new LocalStrategy (username, password, done) ->
    process.nextTick ->
      findByUsername username, (err, user) ->
        if err then console.log 0; return done err
        if !user then console.log 1; return done null, false
        if user.password != password then console.log 2; return done null, false
        done null, user

ensureAuthenticated = (req, res, next) ->
  if req.isAuthenticated() then return next()
  res.redirect '/login'

app.get '/', routes.index
app.get '/login', routes.login
app.get '/system', ensureAuthenticated, system.system
app.post '/sessions', (passport.authenticate 'local', failureRedirect: '/login'), routes.session
app.get '/logout', routes.logout
app.post '/users', routes.newUser

app.listen 3000
console.log "Express server listening on port #{app.address().port} in #{app.settings.env} mode"


