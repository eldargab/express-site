exports.compile = (compiler, src, target, options) ->
    Compiler(compiler, src, target, options).compile()

exports.recompile = (compiler, src, target, options) ->
    Compiler(compiler, src, target, options).recompile()

Compiler = (name, src, target, options) ->
    Comp = require('./'+ name)
    new Comp(src, target, options)