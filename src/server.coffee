express = require 'express'
fs = require 'fs'
cookieParser = require 'cookie-parser'
session = require 'express-session'

Configuration = require './configuration'
Home = require './pages/home'
Login = require './pages/login'
Control = require './pages/control'


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
  home = new Home config
  login = new Login config
  control = new Control config
  app = express()
  app.use '/assets', express.static 'assets'
  app.use cookieParser()
  app.use session secret: '123123123' + Math.random()
  app.get '/', (args...) -> home.get args...
  app.get '/login', (args...) -> login.get args...
  app.post '/login', (args...) -> login.post args...
  app.get '/control', (args...) -> control.get args...
  
  app.listen parseInt(process.argv[3]), (err) ->
    if err?
      console.trace err.toString()
      process.exit()

main()
