crypto = require 'crypto'

defaultInfo =
  title: 'Untitled'
  identification: 'Email'
  adminHash: 'd033e22ae348aeb5660fc2140aec35850c4da997' # "admin"

class Settings
  constructor: (object = defaultInfo) ->
    {@title, @identification, @adminHash} = object
  
  isPassword: (str) ->
    shasum = crypto.createHash 'sha1'
    shasum.update str
    digest = shasum.digest 'hex'
    return digest.toLowerCase() is @adminHash.toLowerCase()
  
  setPassword: (str) ->
    shasum = crypto.createHash 'sha1'
    shasum.update str
    @adminHash = shasum.digest 'hex'
  
  toJSON: ->
    return {
      identification: @identification
      title: @title
      adminHash: @adminHash
    }
  
  @fromJSON: (obj) ->
    if typeof obj isnt 'object'
      throw new TypeError 'invalid Settings type'
    if typeof obj.identification isnt 'string'
      throw new TypeError 'invalid identification type'
    if typeof obj.title isnt 'string'
      throw new TypeError 'invalid title type'
    return new Settings obj

module.exports = Settings
