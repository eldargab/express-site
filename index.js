var Views = require('connect-views')
var express = require('express')


module.exports = function (opts) {
    opts = opts || {}

    var app = express()

    app.use(Views({
        root: '.compiled',
        pathHandler: Views.PathLookup(function (path, req, res) {
            res.sendfile(path)
        })
    }))

    var opts = {
        pathHandler: Views.PathLookup(function (path, req, res, next) {
            opts.render(path, req, res, function (err) {
                if (err) return next(err)
                res.sendfile(path)
            })
        })
    }
    app.use(Views(opts))

    app.use(express.errorHandler())

    var port = opts.port || process.env.PORT || 3000
    app.listen(port)
    console.log('Site is up on http://localhost:' + port)
}