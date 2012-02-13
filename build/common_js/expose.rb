require 'pathname'
require 'json'

class Lib::CommonJS::Exposer
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
      visit_file(p)
    end
  end

  def visit_file(p)
    mod = CommonJS::Module.new(p, p.relative_path_from(@root))
    target_p = @target + mod.name

    if @recompile or not Compiler.uptodate?(p, target_p) then
      deps = mod.dependencies_relative
      .map {|d| "'#{d}'" }
      .join(',')

      exposed_js = "require.register('#{mod.name}', [#{deps}], function (exports, module, require) { #{mod.src_code}});"

      write_file(target_p, exposed_js)
    end
  end
  private :visit_file

  def visit_directory(p)
    main, dep_file = parse_directory(p)
    return unless main

    package_name = p.relative_path_from(@root)
    reg_file = @target + package_name + 'register-package'

    if @recompile or not Compiler.uptodate?(dep_file, reg_file) then
      reg_js = "require.registerPackage('#{package_name}', '#{main}');"
      write_file(reg_file, reg_js)
    end
  end
  private :visit_directory

  def parse_directory(p)
    package_json = p + 'package.json'
    if package_json.exist? then
      config = JSON.parse(read_file(package_json))
      main = config['main']
      return [main, package_json] if main
    end

    index_js = p + 'index.js'
    return [index_js.relative_path_from(@root), index_js] if index_js.exist?
  end
  private :parse_directory
end
