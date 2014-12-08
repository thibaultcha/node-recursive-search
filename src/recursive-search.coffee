fs   = require 'fs'
path = require 'path'
dive = require 'dive'

module.exports =

  recursiveSearchSync: (filename, dir, options) ->
    if arguments.length isnt 3
      options =
        all: false
    matches = []
    f = ((dir) ->
      list = fs.readdirSync dir
      i = 0
      next = (->
        file = list[i++]
        return matches if !file
        file = path.join dir, file
        stat = fs.statSync file
        if stat and stat.isDirectory()
          f file
          next()
        else
          condition = (if (filename.constructor.name is "RegExp") \
                       then path.basename(file).match(filename) \
                       else path.basename(file) is filename)
          if condition or filename is '*'
            if options.all is false
              matches.push file if path.basename(file).charAt(0) isnt '.'
            else
              matches.push file
          next()
      )
      next()
    )
    f dir

    matches

  recursiveSearch: (filename, dir, options, callback, complete) ->
    if arguments.length isnt 5
      complete = callback
      callback = options
      options  =
        all: false
    matches = []
    dive dir, options, (err, file) ->
      return callback err if err
      condition = (if (filename.constructor.name is "RegExp") \
                   then path.basename(file).match(filename) \
                   else path.basename(file) is filename)
      if condition or filename is '*'
        matches.push file
        callback null, file
    , ->
        complete(matches)
