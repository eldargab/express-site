compile = require('./build').compile

task 'build', ->
    invoke 'site.css'

task 'site.css', 'build stylesheets', ->
    compile(
        'less',
        require('glob').sync('./lib/styles/*'),
        './static/res/site.css',
        main: './lib/styles/bootstrap.less'
    )