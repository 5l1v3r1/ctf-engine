Page = require './page'

class Submit extends Page
  path: -> '/submit'
  
  post: (req, res) ->
    @postArgs req, ['name', 'answer'], (err, fields) =>
      return @handleError res, err.message if err?
      for challenge in @config.challenges
        if challenge.name is fields.name
          if challenge.isAnswer fields.answer
            return @handleSuccess res, fields
      @handleError res, 'Incorrect answer!'
  
  handleError: (res, message) ->
    view =
      title: @config.settings.title
      error: message
    @template res, 'wrong.mustache', view
  
  handleSuccess: (res, fields) ->
    view =
      title: @config.settings.title
      identification: @config.settings.identification
      name: fields.name
      answer: fields.answer
    @template res, 'right.mustache', view

module.exports = Submit
