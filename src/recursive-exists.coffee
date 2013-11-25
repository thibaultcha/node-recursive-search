fs   = require 'fs'
path = require 'path'

module.exports =

    recursiveExistsSync: (filename, dir) ->
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
