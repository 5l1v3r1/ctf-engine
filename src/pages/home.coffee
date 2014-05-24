Page = require './page'

class Home extends Page
  path: -> '/'
  
  get: (req, res) ->
    view =
      title: @config.settings.title
      challenges: (x.toMustache() for x in @config.challenges)
    @template res, 'home.mustache', view

module.exports = Home
