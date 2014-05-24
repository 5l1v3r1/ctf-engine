class Submission
  constructor: (@name, @ident, @challenge, @answer) ->
  
  toJSON: -> name: @name, ident: @ident, challenge: @challenge, answer: @answer
  
  @fromJSON: (obj) ->
    if typeof obj.name isnt 'string'
      throw new TypeError 'invalid name type'
    if typeof obj.ident isnt 'string'
      throw new TypeError 'invalid ident type'
    if typeof obj.challenge isnt 'string'
      throw new TypeError 'invalid challenge type'
    if typeof obj.answer isnt 'string'
      throw new TypeError 'invalid answer type'
    return new Submission obj.name, obj.ident, obj.challenge, obj.answer

module.exports = Submission
