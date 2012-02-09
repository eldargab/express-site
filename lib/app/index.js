var express = require('express');
var app = module.exports = express.createServer();

require('./register-templates-extension');
require('./response-render');

app.use(express.static(process.cwd()));
app.use(app.router);
app.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 

app.get('/:page?', M('pages'));

function M (m) {
    return require('../middleware/' + m);
}
