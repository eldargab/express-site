var express = require('express')
var cwd = process.cwd()
var app = module.exports = express()

app.set('views', cwd)
app.set('view engine', 'jade')
require('./engines').extend(app)

app.use(express.bodyParser())
app.use(app.router)
app.use(express.static(cwd + '/.compiled'))
app.use(require('./serve-views'))
app.use(express.static(cwd));
app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))