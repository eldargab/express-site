var fs = require('fs');
var t = require('templates');

require.extensions['.tpl'] = function (module, filename) {
    var content = fs.readFileSync(filename, 'utf8');
    module._compile(t.makeModule(content), filename);
}
