require 'active_support/ordered_options'
require 'active_support/core_ext/hash/reverse_merge'

class String
  def to_slug
    downcase.gsub(/[\W]/, '-')
  end
end

module SimpleSlugs
  autoload :Slugger,  'simple_slugs/slugger'
  autoload :ActMacro, 'simple_slugs/act_macro'

  delegate :slugger,   :to => :'self.class'
  delegate :slug_name, :to => :slugger
  
  def set_slug
    slugger.unique_slug!(self) if slug.blank? || !slugger.on_blank
  end
  
  protected
  
    def taken_slugs(slug)
      slugger.taken_slugs(self, slug)
    end
end

ActiveRecord::Base.extend(SimpleSlugs::ActMacro)