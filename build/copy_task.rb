module Lib
  def copy_task(root, src, dest)
    current_dir = pwd
    cd root
    tasks = FileList[src].map { |src_file|
      dest_path = File.join(dest, src_file)
      src_path = File.join(root, src_file)
      
      file dest_path => src_path do
        make_parent_dir dest_path
        cp(src_path, File.dirname(dest_path))
      end
    }
    cd current_dir
    tasks
  end
end
