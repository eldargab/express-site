Compiler = require('./compiler')
fs = require('fs')

class Concat extends Compiler
    execute: ->
        result = ''
        for s in @src
            result += fs.readFileSync(s, 'utf8')
        @write(result)

module.exports = Concat