Page = require './page'

class Home extends Page
  get: (req, res) ->
    view =
      title: @config.settings.title
      challenges: (x.toJSON() for x in @config.challenges)
    @template res, 'home.mustache', view

module.exports = Home
