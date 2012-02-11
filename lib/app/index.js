var express = require('express');
var m = require('../middleware');
var app = module.exports = express.createServer();

require('./register-templates-extension');
require('./response-render');

app.use(app.router);
app.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 

app.get('/res/*', m.static);
app.get('/favicon.ico', m.static);
app.get('/:page?', m.pages);
