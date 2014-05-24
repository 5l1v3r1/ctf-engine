express = require 'express'
fs = require 'fs'
cookieParser = require 'cookie-parser'
session = require 'express-session'

Configuration = require './configuration'
Submissions = require './submissions'
pages = [
  'home',
  'login'
  'control'
  'add'
  'remove'
  'changebasic'
  'changechal'
  'changepass'
  'submit'
]

main = ->
  if process.argv.length isnt 5
    console.error 'Usage: coffee src/server.coffee <config.json> <submissions.json> <port>'
    process.exit()
  file = process.argv[2]
  subFile = process.argv[3]
  Configuration.load file, (err, config) ->
    if err?
      console.trace err.toString()
      process.exit()
    Submissions.load subFile, (err, subs) ->
      if err?
        console.trace err.toString()
        process.exit()
      setup config, subs

setup = (config, subs) ->
  app = express()
  app.use '/assets', express.static 'assets'
  app.use cookieParser()
  app.use session secret: '123123123' + Math.random()
  for page in pages
    instance = new (require('./pages/' + page)) config, subs
    do (instance) ->
      app.get instance.path(), (args...) -> instance.get args...
      app.post instance.path(), (args...) -> instance.post args...
  # todo change port
  if not port = parseInt process.argv[4]
    console.log 'invalid port: ' + process.argv[4]
    process.exit()
  app.listen port

main()
