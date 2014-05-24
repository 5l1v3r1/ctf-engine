Page = require './page'

class ChangeBasic extends Page
  path: -> '/changebasic'
  
  post: (req, res) ->
    if not req.session.authenticated?
      return res.redirect '/login'
    @postArgs req, ['identification-field', 'title-field'], (err, fields) =>
      return res.send 400, err.message if err?
      ident = fields['identification-field']
      title = fields['title-field']
      @config.settings.identification = ident
      @config.settings.title = title
      @config.save -> res.redirect '/control'

module.exports = ChangeBasic
