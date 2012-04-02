Compiler = require('./compiler')
PATH = require('path')
fs = require('fs')

class Less extends Compiler
    execute: ->
        less = require('less')

        parser = new less.Parser
            filename: @options.main
            paths: @_getPaths()

        parser.parse fs.readFileSync(@options.main, 'utf8'), (error, tree) =>
            throw error if error
            css = tree.toCSS()
            @write(css)

    _getPaths: ->
        set = {}
        for s in @src
            set[PATH.dirname(s)] = true
        Object.keys(set)

module.exports = Less