class Help
    
  def execute(m)
    m.reply("Here's what #{$conf["nick"]} can do: #{descout}")
  end
  
  def descout
    libsdesc = ""
    Dir.get_filenames('lib') do |f, name|
      klass = Extlib::Inflection.camelize(name)
      plugin = Object.const_get(klass)
      libsdesc << "\n!#{name} - #{plugin.description}"      
    end
    libsdesc
  end
  
  def self.description
    "This."
  end
  
end