fs = require 'fs'

class JsonDb
  constructor: (@file) ->
    @isSaving = false
    @waitingSaveCbs = []
  
  save: (cb) ->
    if @isSaving
      @waitingSaveCbs.push cb ? (->)
    else
      @isSaving = true
      data = JSON.stringify @toJSON(), null, 2
      fs.writeFile @file, data, (err) =>
        @isSaving = false
        [newWaiting, @waitingSaveCbs] = [@waitingSaveCbs, []]
        save aCb for aCb in newWaiting
        cb? err
  
  toJSON: -> throw new Error 'JsonDb::toJSON must be overloaded'

module.exports = JsonDb
