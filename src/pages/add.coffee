Page = require './page'
Challenge = require '../challenge'

class Add extends Page
  path: -> '/add'
  
  get: (req, res) ->
    if not req.session.authenticated?
      return res.redirect '/login'
    name = 'Untitled'
    num = 0
    loop
      found = false
      for challenge in @config.challenges
        if challenge.name is name
          found = true
          break
      break if not found
      name = 'Untitled ' + (++num)
    ch = new Challenge name, 'No description',
      'da39a3ee5e6b4b0d3255bfef95601890afd80709' # empty string
    @config.challenges.push ch
    @config.save ->
      res.redirect '/control'

module.exports = Add
