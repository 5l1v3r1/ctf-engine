class Submission
  constructor: (@name, @email, @challenge, @answer) ->
  
  toJSON: -> name: @name, email: @email, challenge: @challenge, answer: @answer
  
  fromJSON: (obj) ->
    if typeof obj.name isnt 'string'
      throw new TypeError 'invalid name type'
    if typeof obj.email isnt 'string'
      throw new TypeError 'invalid email type'
    if typeof obj.challenge isnt 'string'
      throw new TypeError 'invalid challenge type'
    if typeof obj.answer isnt 'string'
      throw new TypeError 'invalid answer type'
    return new Submission obj.name, obj.email, obj.challenge, obj.answer

module.exports = Submission
