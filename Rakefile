require 'rake/clean'
require_relative './build/lib'
include Lib

CLOBBER.include('res')

def client(p = '.')
  File.join('lib/node_modules/client', p)
end

desc 'Create directory with scripts, styles, etc. for client-side'
task :res => [
  :css, 
  :expose_common_js, 
  :package_register,
  *copy_task(client('global-scripts'), '*', 'res')
]

task :css => [:less, *copy_task(client, 'styles/img/*', 'res')]
task :less do
  Less.compile(FileList[client('styles/*.less')], 'res/styles/site.css', :main => client('styles/bootstrap.less'))
end


task :expose_common_js do
  CommonJS::Exposer.expose(client('node_modules'), '.', 'res')
  CommonJS::Exposer.expose(client, 'bootstrap.js', 'res')
end

task :package_register => :expose_common_js do
  Concat.compile(FileList['res/**/register-package'], 'res/package-register.js', :sep => "\n")
end
