Page = require './page'
Busboy = require 'busboy'

class Login extends Page
  get: (req, res) -> @handler res
  
  post: (req, res) ->
    try
      bb = new Busboy headers: req.headers
    catch e
      return @handler res, 'Invalid headers'
    password = null
    bb.on 'field', (name, val) =>
      if name isnt 'password' or password?
        bb.removeAllListeners()
        @handler res, 'Unknown parameter: ' + name
      else
        password = val
    bb.on 'finish', =>
      if typeof password isnt 'string'
        return @handler res, 'Missing parameter: password'
      else
        @_gotPasswordReq password, req, res
    req.pipe bb
  
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
