class ThingsPeopleSay
  
  attr_accessor :coder
  
  def initialize
    self.coder = HTMLEntities.new
  end
    
  def execute(m)
    quote = self.fetch_quote
    m.reply(quote) if m.respond_to?('reply')
  end
  
  def self.description
    "Quotes from the Things People Say at My Work Tumblr."
  end
  
  def url
    "/random"
  end
  
  def url_base
    "http://thingspeoplesayatmywork.tumblr.com"
  end
  
  def fetch_quote
    
    htmlz = self.conn.get self.url
    if htmlz.env[:response_headers]["location"] =~ /#{url_base}(.+)/
      htmlz = self.conn.get $1
      if htmlz.body =~ /<article[^>]+>(.+?)\s+<nav>/m
        subbed= $1.gsub(/<[^>]+>/,"").gsub(/\n\n/m, "\n")
        subbed_sentences = subbed.split("\n")
        subbed = subbed_sentences.join "\n"
        
        begin
          self.coder.decode(subbed)
        rescue Encoding::UndefinedConversionError => e
          puts e.to_s
          subbed.gsub(/(&ldquo;|&rdquo;)/, "\"")
            .gsub(/&#8217;/, "'")
            .gsub(/&#8230;/, "...")
            .gsub(/&amp;/, "&")
        end
      else
        ":("
      end
    else
      ":..("
    end
    
  end
  
  def conn
    @@conn ||= Faraday.new(:url => self.url_base)
  end
  
end