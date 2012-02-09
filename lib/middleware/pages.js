module.exports = function pages (req, res, next) {
    var page = 'pages/' + (req.params.page || 'index');
    var isExist = false;

    try {
        require('client/views/' + page);
        isExist = true;
    }
    catch (e) {}

    if (isExist) { res.render(page) }
    else { next() }
}
