require('fs').readdirSync(__dirname).forEach(function (m) {
    m = m.replace(/(.+)\..*$/, '$1');
    if (m == 'index') return;
    exports[m] = require('./' + m);
});
