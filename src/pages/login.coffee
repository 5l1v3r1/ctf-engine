Page = require './page'

class Login extends Page
  path: -> '/login'
  
  get: (req, res) -> @handler res
  
  post: (req, res) ->
    @postArgs req, ['password'], (err, fields) =>
      return @handler res, err.message if err?
      @_gotPasswordReq fields.password, req, res
  
  handler: (res, error = null) ->
    view =
      title: @config.settings.title
      error: error
    @template res, 'login.mustache', view
  
  _gotPasswordReq: (password, req, res) ->
    if @config.settings.isPassword password
      req.session.authenticated = true
      return res.redirect '/control'
    @handler res, 'Login incorrect'

module.exports = Login
