var express = require('express')
var Views = require('connect-views')

module.exports = function (opts) {
    opts = opts || {}
    opts.root = opts.root || process.cwd()
    var app = express()
    app.use(express.bodyParser())
    app.use(app.router)
    app.use(express.static(opts.root + '/.compiled'))
    app.use(Views(opts))
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))
    if (opts.setup) {
        opts.setup(app)
    }
    return app
}