fs = require 'fs'

Challenge = require './challenge'
Settings = require './settings'

class Configuration
  constructor: (@file, @settings, @challenges) ->
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
        cb? err

  toJSON: ->
    return {
      settings: @settings.toJSON()
      challenges: x.toJSON() for x in @challenges
    }

  @load: (file, cb) ->
    fs.readFile file, (err, data) =>
      if err?
        config = Configuration.newBlank file
        config.save null
        return cb null, config
      try
        obj = JSON.parse data
        result = Configuration.fromJSON file, obj
        cb null, result
      catch e
        return cb e
  
  @fromJSON: (file, obj) ->
    if typeof obj isnt 'object'
      throw new TypeError 'invalid root object type'
    if not Array.isArray obj.challenges
      throw new TypeError 'invalid challenges type'
    challenges = (Challenge.fromJSON x for x in obj.challenges)
    settings = Settings.fromJSON obj.settings
    return new Configuration file, settings, challenges
  
  @newBlank: (file) -> new Configuration file, new Settings(), []

module.exports = Configuration
