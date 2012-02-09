class Lib::CommonJS::ClientModule < Lib::CommonJS::Module
  def dependencies_relative
    src_code[/^.*?\[(.*?)\]/, 1]
      .split(',')
      .map {|s| s[/['"](.*?)['"]/, 1] }    
  end
end
