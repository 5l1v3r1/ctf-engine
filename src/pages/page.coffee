fs = require 'fs'
mustache = require 'mustache'

class Page
  constructor: (@config) ->
  get: (req, res) -> res.send 404, 'Page::get() not overloaded'
  post: (req, res) -> res.send 404, 'Page::post() not overloaded'
  template: (res, name, view) ->
    fs.readFile 'templates/' + name, (err, data) ->
      return res.send 500, 'Failed to read templates/' + name if err?
      try
        output = mustache.render data.toString(), view
      catch e
        return res.send 500, 'Failed to render view: ' + e.toString()
      res.send output

module.exports = Page
