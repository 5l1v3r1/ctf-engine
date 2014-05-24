express = require 'express'
fs = require 'fs'

Configuration = require './configuration'
HomePage = require './home-page'

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
  HomePage.config = config
  app = express()
  app.get '/', HomePage.handle
  app.listen parseInt(process.argv[3]), (err) ->
    if err?
      console.trace err.toString()
      process.exit()

main()
