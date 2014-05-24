class SubmitInfo
  constructor: (@identification = 'Email') ->
  
  toJSON: -> identification: @identification
  
  @fromJSON: (obj) ->
    if typeof obj isnt 'object'
      throw new TypeError 'invalid type'
    if typeof obj.identification isnt 'string'
      throw new TypeError 'invalid identification type'
    return new SubmitInfo obj.identification

module.exports = SubmitInfo
