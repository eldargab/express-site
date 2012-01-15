module Lib
  class Less < Compiler
    def execute
      main = @sources.length > 1 ? @options[:main] : @sources[0]

      node_sh("lessc #{main} > #{@target}") {|ok|
        next if ok
        begin
          result = read_file(@target)
          del @target
        rescue
        end
        raise result || "Error occured while compiling #{main}"
      }
    end
  end
end
