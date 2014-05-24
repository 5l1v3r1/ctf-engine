crypto = require 'crypto'

class Challenge
  constructor: (@name, @body, @answerHash) ->
  
  isAnswer: (str) ->
    shasum = crypto.createHash 'sha1'
    shasum.update str
    digest = shasum.digest 'hex'
    return digest.toLowerCase() is @answerHash.toLowerCase()
  
  toJSON: ->
    return {
      name: @name
      body: @body
      answerHash: @answerHash
    }
  
  toMustache: ->
    obj = @toJSON()
    obj.nameEscaped = encodeURIComponent obj.name
    return obj
  
  @fromJSON: (obj) ->
    if typeof obj.name isnt 'string'
      throw new TypeError 'invalid name type'
    if typeof obj.body isnt 'string'
      throw new TypeError 'invalid body type'
    if typeof obj.answerHash isnt 'string'
      throw new TypeError 'invalid answerHash type'
    return new Challenge obj.name, obj.body, obj.answerHash

module.exports = Challenge
