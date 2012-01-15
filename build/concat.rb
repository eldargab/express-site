module Lib
  class Concat < Compiler
    def execute
      to_concat = []
      @sources.each {|src|
        to_concat << read_file(src)
      }
      write_file(@target, to_concat.join("\n\n\n"))
    end
  end
end
