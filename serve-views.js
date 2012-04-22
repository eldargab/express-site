var parseUrl = require('url').parse
var PATH = require('path')

module.exports = function serveViews (req, res, next) {
    var app = req.app

    var path = decodeURIComponent(parseUrl(req.url).pathname)
    if (path[path.length - 1] == '/') path += 'index'
    var ext = PATH.extname(path)
    if (!ext) {
        ext += '.' + app.get('view engine')
        path = path + ext
    }
    path = path.substring(1) // trim leading slash

    if (!app.engines[ext]) return next()

    var filePath = PATH.join(app.get('views') || process.cwd(), path)

    PATH.exists(filePath, function (exists) {
        if (!exists) return next()
        res.render(path)
    })
}