class Lib::CommonJS::Module
  def self.resolve_relative_name(from, name)
    return name unless name[0] == '.' or name == '..'
    File.join(from, name)
  end

  def initialize(path, name)
    @path = path.to_s
    @name = name
  end

  attr_reader :name, :path

  def src_code
    @src_code || @src_code = read_file(@path)
  end

  def dependencies_relative
    src_code
      .gsub(%r|/\*.*?\*/|m, '') # block comments
      .gsub(%r|^//.*|, '') # line comments
      .scan(/require\s*\(['"]([^\s'"]+)['"]\)/)
      .flatten
  end

  def dependencies
    dependencies_relative.map {|dep|
      resolve_relative_name(@name, dep)
    }
  end
end
