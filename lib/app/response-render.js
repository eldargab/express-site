var res = require('http').ServerResponse.prototype;

res.render = function (view, var_data) {
    var data = Array.prototype.slice.call(arguments, 1);
    var body = view ? require('client/views/' + view).apply(null, data) : '';
    if (this.req.xhr) {
        this.send(body);
    }
    else {
        this.send(require('client/views/layout')(body));
    }
}

delete res.partial, res.locals, res.local;
