fs = require('fs')

class Compiler
    constructor: (@src, @target, @options = {}) ->
        @src = [@src] unless Array.isArray(@src)

    compile: ->
        @recompile() unless @isUptodate()

    recompile: ->
        @message()
        require('mkdirp').sync require('path').dirname(@target)
        @execute()

    isUptodate: ->
        try
            tMtime = fs.statSync(@target).mtime
        catch e
            if e.code != 'ENOENT' then throw e

        return false unless tMtime

        for s in @src
            return false if fs.statSync(s).mtime >= tMtime

        true

    message: ->
        console.log("Compiling #{@target}")

    write: (string) ->
        fs.writeFileSync(@target, string, 'utf8')

    execute: ->

module.exports = Compiler