module SimpleSlugs
  class Slug < String
    def initialize(string)
      super
      normalize
    end
    
    def normalize
      transliterate
      spacify
      strip!
      downcase!
      dasherize
    end
    
    def transliterate
      replace(I18n.transliterate(self))
    end
    
    def spacify
      gsub!(/[\W_]/, ' ')
    end
    
    def dasherize
      gsub!(' ', '-')
    end
  
    # def normalize(ascii = false)
    #   if ascii
    #     approximate_ascii
    #     to_ascii
    #   end
    #   clean
    #   word_chars
    #   clean
    #   downcase
    #   truncate_bytes(255)
    #   with_dashes
    # end
  end
end