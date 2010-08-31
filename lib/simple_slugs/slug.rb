module SimpleSlugs
  class Slug < String
    def initialize(string)
      super
      normalize
    end
    
    def normalize
      transliterate
      decolonize
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

    def decolonize
      gsub!(/:/, '')
    end
    
    def dasherize
      gsub!(' ', '-')
    end
  end
end
