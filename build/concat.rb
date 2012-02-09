module Lib
  class Concat < Compiler
    def execute
      to_concat = []
      @sources.each {|src|
        to_concat << read_file(src)
      }
      sep = (@options && @options[:sep]) || ""
      write_file(@target, to_concat.join(sep))
    end
  end
end
