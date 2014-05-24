Submission = require './submission'
JsonDb = require './jsondb'
fs = require 'fs'

class Submissions extends JsonDb
  constructor: (@file, @submissions = []) -> super @file
  
  toJSON: -> x.toJSON() for x in @submissions
  
  @fromJSON: (file, obj) ->
    if not Array.isArray obj
      throw new TypeError 'invalid root object type'
    subs = (Submission.fromJSON x for x in obj)
    return new Submissions file, subs
  
  @load: (file, cb) ->
    fs.readFile file, (err, data) =>
      if err?
        res = new Submissions file
        res.save null
        return cb null, res
      try
        obj = JSON.parse data
        result = Submissions.fromJSON file, obj
        cb null, result
      catch e
        return cb e

module.exports = Submissions
