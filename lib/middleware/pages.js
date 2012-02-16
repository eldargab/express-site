module.exports = function pages (req, res, next) {
    var page = req.params.page || 'index';
    var template;

    try {
        template = require('client/pages/' + page);
    }
    catch (e) {}

    if (!template) return next();

    var content = template();
    res.send(req.xhr ? content : require('client/pages/layout')(content));
}
