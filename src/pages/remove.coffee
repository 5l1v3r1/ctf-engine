Page = require './page'
Challenge = require '../challenge'

class Remove extends Page
  path: -> '/remove'
  
  get: (req, res) ->
    if not req.session.authenticated?
      return res.redirect '/login'
    if typeof req.query.name isnt 'string'
      return res.send 400, 'Invalid name parameter'
    {name} = req.query
    for challenge, i in @config.challenges
      if challenge.name is name
        @config.challenges.splice i, 1
        break
    @config.save ->
      res.redirect '/control'

module.exports = Remove
