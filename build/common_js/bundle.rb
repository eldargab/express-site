require 'set'

class Lib::CommonJS::Bundle
  def initialize(get_main_module)
    @get_main_module = get_main_module
    @bundle = ''
    @included = Set.new
  end

  def add_string(string, sep = "\n\n\n")
    @bundle << sep << string
  end

  def add_module(name)
    mod = @get_main_module.call(name)
    return if @included.include? mod.path

    add_string(mod.src_code)
    @included << mod.path

    mod.dependencies.each {|dep| 
      add_module(dep) 
    }
  end

  def to_s
    @bundle
  end
end
# 
# class Lib::Modules
#   def initialize(root)
#     @root = root
#     @pack_reg = PackageRegister.new(File.join(root, 'package-register.js'))
#   end
# 
#   def [](name)
#     main = @pack_reg.get_main(name)
#     file = File.join(@root, main)
#     Module.new(name, main, file)
#   end
# end
# 
# class Lib::PackageRegister
#   def initialize(reg_file)
#     @packages = Hash.new 
#     
#     read_file(reg_file)
#       .scan(/require\.register\(['"](.*?)['"]\s*,\s*['"](.*?)['"]\s*\)/)
#       .each {|m| @packages[m[0]] = m[1] }
#   end
# 
#   def get_main(mod)
#     main = @packages[mod]
#     (main && File.join(mod, main)) || mod
#   end
# end
