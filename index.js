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
    app.use(express.static(opts.root))
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))
    if (opts.setup) {
        opts.setup(app)
    }
    if (opts.start) {
        opts.start(app)
    } else {
        var port = opts.port || process.env.port || 3000
        app.listen(port)
        console.log('Site http://localhost:' + port + ' launched for ' + opts.root)
    }
    return app
}