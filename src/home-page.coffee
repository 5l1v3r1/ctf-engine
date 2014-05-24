mustache = require 'mustache'
fs = require 'fs'

handle = (req, res) ->
  {config} = module.exports
  view =
    title: config.title
    challenges: (x.toJSON() for x in config.challenges)
  fs.readFile 'pages/home.mustache', (err, data) ->
    return res.send 500, 'Failed to read pages/home.mustache' if err?
    try
      output = mustache.render data.toString(), view
    catch e
      return res.send 500, 'Failed to render mustache view: ' + e.toString()
    res.send output

module.exports =
  handle: handle
  config: null
