Challenge = require './challenge'
fs = require 'fs'

class Configuration
  constructor: (@file, @title, @challenges) ->
    @isSaving = false
    @waitingSaveCbs = []
  
  save: (cb) ->
    if @isSaving
      @waitingSaveCbs.push cb
    else
      @isSaving = true
      data = JSON.stringify @toJSON(), null, 2
      fs.writeFile @file, data, (err) =>
        @isSaving = false
        [newWaiting, @waitingSaveCbs] = [@waitingSaveCbs, []]
        save aCb for aCb in newWaiting
        cb err

  toJSON: ->
    return
      title: @title
      challenges: x.toJSON() for x in @challenges

  @load: (file, cb) ->
    fs.readFile file, (err, data) =>
      return cb err if err?
      try
        obj = JSON.parse data
        result = Configuration.fromJSON file, obj
        cb null, result
      catch e
        return cb e
  
  @fromJSON: (file, obj) ->
    if typeof obj isnt 'object'
      throw new TypeError 'invalid root object type'
    if typeof obj.title isnt 'string'
      throw new TypeError 'invalid title type'
    if not Array.isArray obj.challenges
      throw new TypeError 'invalid challenges type'
    challenges = (Challenge.fromJSON x for x in obj.challenges)
    return new Configuration file, obj.title, challenges

module.exports = Configuration
