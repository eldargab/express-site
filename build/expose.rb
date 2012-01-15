require 'json'
require 'pathname'

module Lib
  class Exposer
    def self.expose(root, mod, target)
      i = self.new(root, target)
      i.visit(File.join(root, mod))
    end

    def initialize(root, target, recompile = false)
      @root = Pathname.new root
      @target = Pathname.new target
      @recompile = recompile
    end

    def visit(p)
      p = Pathname.new(p)
      if p.directory? then
        visit_directory(p)
        p.children.reject {|ch| ch.basename.to_s =~ /^(bin)|(test)$/}.each {|ch|
          visit(ch)
        }
      else
        visitor = "visit_#{p.extname.delete('.')}_file"
        send(visitor, p) if respond_to? visitor, true
      end
    end

    def visit_js_file(p)
      module_name = p.relative_path_from(@root)
      target_p = @target + module_name

      if @recompile or not Compiler.uptodate?(p, target_p) then
        js_string = read_file(p)

        requires = js_string
          .gsub(%r|/\*.*?\*/|m, '') # block comments
          .gsub(%r|^//.*|, '') # line comments
          .scan(/require\s*\((['"][^\s'"]+['"])\)/)
          .flatten

        wrapped_js = "require.register('#{module_name}', [#{requires.join(',')}], function (exports, module, require) { #{js_string} });"
        write_file(target_p, wrapped_js)
      end
    end
    private :visit_js_file

    def visit_directory(p)
      package_json = p + 'package.json'
      if package_json.exist? then
        config = JSON.parse(read_file(package_json))
        main = config['main']
        return _register_package(p, main, package_json) if main
      end

      index_js = p + 'index.js'
      _register_package(p, 'index.js', p) if index_js.exist?
    end
    private :visit_directory

    def _register_package(dir, main, dep)
      if (main[0] != '.' and main[0] != '..' and main[0] != '/') then
        main = './' + main
      end

      package_name = dir.relative_path_from(@root)
      reg_file = @target + package_name + 'register-package'

      if @recompile or not Compiler.uptodate?(dep, reg_file) then
        reg_js = "require.registerPackage('#{package_name}', '#{main}')"
        write_file(reg_file, reg_js)
      end
    end
    private :_register_package
  end
end
