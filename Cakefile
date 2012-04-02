compile = require('./build').compile

task 'build', ->
    invoke 'site.css'

task 'site.css', 'build stylesheets', ->
    glob = require('glob').sync

    compile(
        'less',
        glob('./lib/styles/*'),
        './static/res/site.css',
        main: './lib/styles/bootstrap.less'
    )
    compile 'cp', glob('lib/styles/img/*'), 'static/res'