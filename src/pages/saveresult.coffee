Page = require './page'
Submission = require '../submission'

class SaveResult extends Page
  path: -> '/saveresult'
  
  post: (req, res) ->
    tags = ['name', 'answer', 'full-name', 'identification']
    @postArgs req, tags, (err, fields) =>
      return @handleError res, err.message if err?
      for challenge in @config.challenges
        if challenge.name is fields.name
          if challenge.isAnswer fields.answer
            return @handleFields res, fields
      @handleError res, 'Invalid challenge/answer'
  
  handleError: (res, msg) ->
    return res.send 400, msg
  
  handleFields: (res, fields) ->
    if 0 in [fields['full-name'].length, fields.identification.length]
      return @handleInvalid res, fields
    # make the entry
    sub = new Submission fields['full-name'], fields.identification,
      fields.name, fields.answer
    @subs.submissions.push sub
    @subs.save -> res.redirect '/'
  
  handleInvalid: (res, fields) ->
    view =
      title: @config.settings.title
      identification: @config.settings.identification
      name: fields.name
      answer: fields.answer
      error: 'Invalid input'
    @template res, 'right.mustache', view


module.exports = SaveResult
