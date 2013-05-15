class ScrumWord
  attr_accessor :position, :word, :part_of_speech
  
  def to_s
    "#{word} #{part_of_speech} #{position}"
  end
  
end

class Scrum

  cattr_accessor :tagger
  attr_accessor :words, :word, :sentence
  
  def initialize
    self.words = Array.new
  end
  
  def execute(m)
    quote = self.tag
    puts quote
    m.reply("\"#{quote}\" -- The Scrum Lord") if m.respond_to?('reply')
  end
  
  def self.description
    "Poignant quotes about scrum."
  end
  
  def tag
     self.class.tagger ||= EngTagger.new
     self.sentence = self.fetch_quote
     tagged = self.class.tagger.add_tags(self.sentence)
     self.chew tagged
     self.find_replace_word
     self.replace_word_in_sentence
  end
  
  def chew(tagged)
    tagged.split(/ /).each_with_index do |chunk, i|
      if chunk =~ /<(\w+)>(.+)<\/\w+>/
        w = ScrumWord.new
        w.position = i
        w.part_of_speech = $1.upcase
        w.word = $2
        self.words << w
      end
    end
    
  end
  
  def find_replace_word
    sentence = self.words.dup
    
    while true do
      curword = sentence.sample
      sentence.delete_at(curword.position)
      replace_word = scrumify curword.part_of_speech

      if replace_word
        self.word = curword.dup
        self.word.word = replace_word
        return true
      end
      
    end
  end
  
  def replace_word_in_sentence
    return ":(" if not self.word
        
    self.words[self.word.position] = self.word
    sentence = self.words.collect(&:word).join " "
    sentence.gsub(/ (\.|,|\!|;|'|"|\?)/, '\1')
  end
    
  def scrumify(pos)
  	if pos == 'JJ' 
  		return 'scrummy'
  	elsif pos == 'JJR'
  		return 'scrummer'
  	elsif pos == 'JJS'
  		return 'scrummest'
  	elsif pos == 'NN'
  		return 'scrum'
  	elsif pos == 'NNS'
  		return 'scrums'
    #elsif pos == 'RB'
  	#return 'scrumily'
  	elsif pos == 'RBR'
  		return 'scrumlier'
  	elsif pos == 'RBS'
  		return 'scrumliest'
  	elsif pos == 'VB'
  		return 'scrum'
  	elsif pos == 'VBD'
  		return 'scrummed'
  	elsif pos == 'VBG'
  		return 'scrumming'
  	elsif pos == 'VBN'
  		return 'scrummed'
  	elsif pos == 'VBP'
  		return 'scrum'
  	elsif pos == 'VBZ'
  		return 'scrums'  
    end
  end
  
  def url
    "/random.php3?number=1"
  end
  
  def url_base
    "http://www.quotationspage.com"
  end
  
  def fetch_quote
    
    htmlz = self.conn.get self.url
    if htmlz.body =~ /<dt.+><a.+>([^<]+)<\/a>\s*<\/dt>/mi
      puts $1
      $1
    else
      "The quick brown fox jumped over the lazy dog."
    end

  end
  
  def conn
    @@conn ||= Faraday.new(:url => self.url_base)
  end
  
end


__END__

"CC",   "Conjunction, coordinating",
"CD",   "Adjective, cardinal number",
"DET",  "Determiner",
"EX",   "Pronoun, existential there",
"FW",   "Foreign words",
"IN",   "Preposition / Conjunction",
"JJ",   "Adjective",
"JJR",  "Adjective, comparative",
"JJS",  "Adjective, superlative",
"LS",   "Symbol, list item",
"MD",   "Verb, modal",
"NN",   "Noun",
"NNP",  "Noun, proper",
"NNPS", "Noun, proper, plural",
"NNS",  "Noun, plural",
"PDT",  "Determiner, prequalifier",
"POS",  "Possessive",
"PRP",  "Determiner, possessive second",
"PRPS", "Determiner, possessive",
"RB",   "Adverb",
"RBR",  "Adverb, comparative",
"RBS",  "Adverb, superlative",
"RP",   "Adverb, particle",
"SYM",  "Symbol",
"TO",   "Preposition",
"UH",   "Interjection",
"VB",   "Verb, infinitive",
"VBD",  "Verb, past tense",
"VBG",  "Verb, gerund",
"VBN",  "Verb, past/passive participle",
"VBP",  "Verb, base present form",
"VBZ",  "Verb, present 3SG -s form",
"WDT",  "Determiner, question",
"WP",   "Pronoun, question",
"WPS",  "Determiner, possessive & question",
"WRB",  "Adverb, question",
"PP",   "Punctuation, sentence ender",
"PPC",  "Punctuation, comma",
"PPD",  "Punctuation, dollar sign",
"PPL",  "Punctuation, quotation mark left",
"PPR",  "Punctuation, quotation mark right",
"PPS",  "Punctuation, colon, semicolon, elipsis",
"LRB",  "Punctuation, left bracket",
"RRB",  "Punctuation, right bracket"