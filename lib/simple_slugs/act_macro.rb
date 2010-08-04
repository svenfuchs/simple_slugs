module SimpleSlugs
  module ActMacro
    def has_slug(options = {})
      return if respond_to?(:slugger)

      before_validation lambda { |record| record.slugger.unique_slug!(record) }

      class_inheritable_accessor :slugger
      self.slugger = Slugger.new(self, options)
    end
  end
end