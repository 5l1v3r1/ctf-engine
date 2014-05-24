Page = require './page'

class ChangePass extends Page
  path: -> '/changepass'
  
  post: (req, res) ->
    if not req.session.authenticated?
      return res.redirect 'login'
    @postArgs req, ['password', 'verify-password'], (err, fields) =>
      return res.send 400, err.message if err?
      if fields.password isnt fields['verify-password']
        message = '<!doctype html><html><body>Passwords do not match' +
          ' <a href="/control">Go Back</a></body></html>'
        return res.send message
      @config.settings.setPassword fields.password
      @config.save -> res.redirect 'control'

module.exports = ChangePass
