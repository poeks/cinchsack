class Dir
  
  def self.get_filenames(dir, &block)
    libs = Array.new
    self.glob_em(dir) do |f|
      if f =~ %r{./#{dir}/([^\.]+).rb}
        libs << $1
        block.call(f, $1) if block_given?
      end
    end
    libs
  end
  
  def self.glob_em(dir, &block)
    Dir.glob(File.join("./#{dir}/*.rb")).each do |f|
      block.call(f) if block_given?
    end
  end
  
end