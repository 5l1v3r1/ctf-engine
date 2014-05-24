Page = require './page'

class Logout extends Page
  path: -> '/logout'
  
  get: (req, res) ->
    delete req.session.authenticated
    res.redirect '/'

module.exports = Logout
