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
      gsub!(/\s+/, ' ')
    end
    
    def dasherize
      gsub!(' ', '-')
    end
  end
end
