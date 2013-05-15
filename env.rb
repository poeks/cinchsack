require 'rubygems'
require 'bundler'
Bundler.require :default

bot = Cinch::Bot.new do
  
  configure do |c|
    conf = JSON.load File.open ENV['EYEARCEE_CONFIG_FILE']
    conf.each_pair do |key, value|
      c.send("#{key}=", value)
    end

    c.ssl.use = ENV['EYEARCEE_SSL']
  end
  
  Dir.glob(File.join('./lib/*.rb')).each do |f| 
    
    require f 
    if f =~ %r{./lib/([^\.]+).rb}
      
      name = $1
      klass = Extlib::Inflection.classify(name)
      plugin = Kernel.const_get(klass).new
      
      on :message, /^#{name}*/ do |m|
        plugin.execute(m)
      end
      
    end
    
  end
    
end

bot.start