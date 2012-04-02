fs = require('fs')
PATH = require('path')
Compiler = require('./compiler')

class Copy extends Compiler
    isUptodate: -> false

    message: ->

    execute: ->
        for s in @src
            filename = PATH.basename(s)
            target = PATH.join(@target, filename)
            unless isUptodate(s, target)
                console.log("cp #{s} #{@target}")
                fs.writeFileSync(target, fs.readFileSync(s, 'utf8'), 'utf8')



isUptodate = (src, target) ->
    try
        tMtime = fs.statSync(@target).mtime
    catch e
        if e.code != 'ENOENT' then throw e

    tMtime && (fs.statSync(s).mtime < tMtime)

module.exports = Copy