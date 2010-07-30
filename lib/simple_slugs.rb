require 'active_support/ordered_options'
require 'active_support/core_ext/hash/reverse_merge'

module SimpleSlugs
  autoload :Slug,     'simple_slugs/slug'
  autoload :Slugger,  'simple_slugs/slugger'
  autoload :ActMacro, 'simple_slugs/act_macro'
end

class String
  def to_slug
    SimpleSlugs::Slug.new(self)
  end
end

ActiveRecord::Base.extend(SimpleSlugs::ActMacro)