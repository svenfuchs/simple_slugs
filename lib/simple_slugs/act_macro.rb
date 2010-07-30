module SimpleSlugs
  module ActMacro
    def has_slug(options = {})
      return if has_slug?

      before_validation lambda { |record| record.slugger.unique_slug!(record) }

      class_inheritable_accessor :slugger
      self.slugger = Slugger.new(self, options)
    end

    def has_slug?
      included_modules.include?(SimpleSlugs)
    end
  end
end