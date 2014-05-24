Page = require './page'

class Control extends Page
  get: (req, res) ->
    if not req.session.authenticated?
      return res.redirect '/login'
    view =
      title: @config.settings.title
      identification: @config.settings.identification
      challenges: (x.toJSON() for x in @config.challenges)
    @template res, 'control.mustache', view

module.exports = Control
