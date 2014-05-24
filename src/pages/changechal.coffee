Page = require './page'

class ChangeChal extends Page
  path: -> '/changechal'
  
  post: (req, res) ->
    if not req.session.authenticated?
      return res.redirect 'login'
    args = [
      'name'
      'challenge-name'
      'challenge-body'
      'challenge-hash'
    ]
    @postArgs req, args, (err, fields) =>
      return res.send 400, err.message if err?
      # find the challenge in question
      for challenge in @config.challenges
        if challenge.name is fields.name
          challenge.name = fields['challenge-name']
          challenge.body = fields['challenge-body']
          challenge.answerHash = fields['challenge-hash']
          break
      @config.save -> res.redirect 'control'

module.exports = ChangeChal
