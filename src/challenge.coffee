crypto = require 'crypto'

class Challenge
  constructor: (@name, @body, @answerHash, @hints = []) ->
  
  isAnswer: (str) ->
    shasum = crypto.createHash 'sha1'
    shasum.update str
    digest = shasum.digest 'hex'
    return digest.toLowerCase() is @answerHash.toLowerCase()
  
  toJSON: ->
    return
      name: @name
      body: @body
      answerHash: @answerHash
      hints: @hints
  
  @fromJSON: (obj) ->
    if typeof obj.name isnt 'string'
      throw new TypeError 'invalid name type'
    if typeof obj.body isnt 'string'
      throw new TypeError 'invalid body type'
    if typeof obj.answerHash isnt 'string'
      throw new TypeError 'invalid answerHash type'
    if Array.isArray obj.hints
      throw new TypeError 'invalid hints type'
    # make sure the types in obj.hints are good
    for x, i in obj.hints
      if typeof x isnt 'string'
        throw new TypeError "invalid hints[#{i}] type"
    return new Challenge obj.name, obj.body, obj.answerHash, obj.hints

module.exports = Challenge
