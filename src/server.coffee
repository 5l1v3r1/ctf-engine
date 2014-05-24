express = require 'express'
fs = require 'fs'
cookieParser = require 'cookie-parser'
session = require 'express-session'

Configuration = require './configuration'
pages = ['home', 'login', 'control', 'add', 'remove']

main = ->
  if process.argv.length isnt 4
    console.error 'Usage: coffee src/server.coffee <config.json> <port>'
    process.exit()
  file = process.argv[2]
  Configuration.load file, (err, config) ->
    if err?
      console.trace err.toString()
      process.exit()
    setup config

setup = (config) ->
  app = express()
  app.use '/assets', express.static 'assets'
  app.use cookieParser()
  app.use session secret: '123123123' + Math.random()
  for page in pages
    instance = new (require('./pages/' + page)) config
    do (instance) ->
      app.get instance.path(), (args...) -> instance.get args...
      app.post instance.path(), (args...) -> instance.post args...
  app.listen parseInt(process.argv[3]), (err) ->
    if err?
      console.trace err.toString()
      process.exit()

main()
