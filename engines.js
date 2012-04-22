exports.extend = function (app, coll) {
    coll = coll || exports.collection
    for (var key in coll) {
        app.engine(key, coll[key])
    }
}

exports.collection = {}

var cons = require('consolidate')

Object.keys(cons).forEach(function (key) {
    if (key == 'clearCache' || typeof cons[key] != 'function') return
    exports.collection[key] = cons[key]
})