fs   = require 'fs'
path = require 'path'
dive = require 'dive'

module.exports =

    recursiveSearchSync: (filename, dir) ->
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
                    matches.push file if path.basename(file) is filename
                    next()
            )
            next()
        )
        f dir

        matches

    recursiveSearch: (filename, dir, callback, complete) ->
        results = []
        (->
            dive dir, (err, file) ->
                return callback err if err
                if path.basename(file) is filename
                    results.push file
                    callback null, file
            , ->
                complete(results)
        )()
