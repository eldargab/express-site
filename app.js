var express = require('express')
var app = module.exports = express.createServer()

app.set('views', __dirname + '/lib/views')
app.set('view engine', 'jade')
app.set('view options', {layout: false})

app.use(express.bodyParser())
app.use(app.router)
app.use(express.static(__dirname + '/static'))
app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))

app.get('/', function (req, res) {
    res.render('index')
})

app.listen(3000)
console.log('Express server listening...')