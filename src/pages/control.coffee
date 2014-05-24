Page = require './page'

class Control extends Page
  path: -> '/control'
  
  get: (req, res) ->
    if not req.session.authenticated?
      return res.redirect 'login'
    res.header 'Cache-Control', 'no-cache, no-store, must-revalidate'
    view =
      title: @config.settings.title
      identification: @config.settings.identification
      challenges: (x.toMustache() for x in @config.challenges)
    @template res, 'control.mustache', view

module.exports = Control
