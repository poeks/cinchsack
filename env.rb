require 'rubygems'
require 'bundler'
Bundler.require :default

bot = Cinch::Bot.new do
 
  require './ext/dir'
  Dir.glob_em('ext') do |f|
    require f
  end
  
  Dir.get_filenames('lib') do |f, name| 
    
    require f 
    
    on :message, /^\!#{name}*/ do |m|
      klass          = Extlib::Inflection.camelize(name)
      plugin         = Object.const_get(klass).new
      plugin.execute(m)
      plugin         = nil
    end
     
  end
  
  configure do |c|
    $conf = JSON.load File.open ENV['EYEARCEE_CONFIG_FILE']
    $conf.each_pair do |key, value|
      c.send("#{key}=", value)
    end
    c.ssl.use = ENV['EYEARCEE_SSL']
  end if ENV['EYEARCEE_PRODUCTION']
  
end

bot.start if ENV['EYEARCEE_PRODUCTION']