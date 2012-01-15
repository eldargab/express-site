require_relative './build/lib'
include Lib

desc 'Run tests'
task :test do
    node_sh 'mocha'
end

desc 'Create directory with scripts, styles, etc. for client-side'
task :res

task :styles do
  Less.compile(FileList['ui/styles/site/**/*.less'], 'res/styles/site.css', :main => 'ui/styles/site/bootstrap.less')
end

task :res => :styles
