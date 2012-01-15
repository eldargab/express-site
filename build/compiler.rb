module Lib
  class Compiler
    def initialize(sources, target, *options)
      @target = target
      @sources = to_array(sources)
      @options = options.length > 1 ? options : options[0]
    end

    def compile
      recompile if not uptodate?
    end

    def recompile
      make_parent_dir @target
      execute
    end

    def uptodate?
      uptodate = true
      if File.exist?(@target) then
        @sources.each { |src|
          uptodate = false if File.mtime(src) > File.mtime(@target)
          break if not uptodate 
        }
      else
        uptodate = false
      end
      uptodate
    end

    def self.compile(*args)
      self.new(*args).compile
    end

    def self.recompile(*args)
      self.new(*args).recompile
    end

    def self.uptodate?(*args)
      self.new(*args).uptodate?
    end
  end
end

def to_array(obj)
  return obj if obj.is_a? Array
  return obj.to_ary if obj.respond_to? :to_ary
  [obj]
end
