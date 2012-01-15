module Lib
  def make_parent_dir(path)
    dir = File.dirname(path)
    mkpath(dir) unless File.exist?(dir)
  end

  def write_file(path, string)
    make_parent_dir(path)
    File.write(path, string, :encoding => 'utf-8')
  end

  def read_file(name)
    File.read(name, :encoding => 'utf-8')
  end

  def node_sh(command, &b)
    bin, *args = command.split(' ')
    bin = File.join('node_modules/.bin', bin)
    bin = bin.gsub(/\//, "\\") if Rake::Win32.windows? 
    comm = bin + ' ' + args.join(' ')
    sh(comm, &b)
  end
end
