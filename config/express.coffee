express = require 'express'
glob = require 'glob'

favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
compress = require 'compression'
methodOverride = require 'method-override'
moment = require('moment');
coffeeScript = require('coffee-script')
fs = require 'fs'
path = require('path')
#connectCoffeescript = require('connect-coffee-script')

nucompile = (str, options) ->
  options.bare = true
  coffeeScript.compile  str, options

module.exports = (app, config) ->
  app.set 'views', config.root + '/app/views'
  app.set 'view engine', 'jade'

  env = process.env.NODE_ENV || 'development'
  app.locals.ENV = env
  app.locals.ENV_DEVELOPMENT = env == 'development'
  app.locals.moment = moment
  app.locals.pretty = true;

# app.use(favicon(config.root + '/public/img/favicon.ico'));
  app.use logger 'dev'
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(
    extended: true
  )
  app.use cookieParser()
  app.use compress()
  app.use express.static config.root + '/public'
  app.use methodOverride()

#  app.use connectCoffeescript
#    src: config.root + '/app/utils',
#    dest: config.root + '/public/utils',
##    compile: nucompile
#    bare: true

  app.use '/utils', (request, response, next) ->
#    coffeeFile = path.join __dirname, "../app/utils", request.path
    coffeeFile = config.root + '/app/utils/' +  request.path
    console.log("coffeeFile: " + coffeeFile);
    file = fs.readFile coffeeFile, "utf-8", (err, data) ->
      return next() if err?
      response
        .contentType('text/javascript')
        .send coffeeScript.compile data

  controllers = glob.sync config.root + '/app/controllers/**/*.coffee'
  controllers.forEach (controller) ->
    require(controller)(app);

  # catch 404 and forward to error handler
  app.use (req, res, next) ->
    err = new Error 'Not Found'
    err.status = 404
    next err

  # error handlers

  # development error handler
  # will print stacktrace

  if app.get('env') == 'development'
    app.use (err, req, res, next) ->
      res.status err.status || 500
      res.render 'error',
        message: err.message
        error: err
        title: 'error'

  # production error handler
  # no stacktraces leaked to user
  app.use (err, req, res, next) ->
    res.status err.status || 500
    res.render 'error',
      message: err.message
      error: {}
      title: 'error'

