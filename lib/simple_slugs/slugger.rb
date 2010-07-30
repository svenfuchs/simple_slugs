module SimpleSlugs
  class Slugger < ActiveSupport::InheritableOptions
    DEFAULTS = {
      :on_blank  => true,
      :scope     => nil,
      :separator => '-'
    }
    
    attr_reader :model
    
    def initialize(model, options)
      @model = model
      super(options.reverse_merge(DEFAULTS))
    end
    
    def unique_slug!(record)
      slug = base_slug = record.read_attribute(source).to_slug
      taken_slugs, n = self.taken_slugs(record, slug), 0
      slug = [base_slug, separator, n += 1].join while taken_slugs.include?(slug)
      record.slug = slug
    end
  
    protected
    
      def taken_slugs(record, slug)
        condition = model.arel_table[:slug].matches("#{slug}%")
        slug_scope(record).where(condition).select(:slug).map(&:slug)
      end
    
      def slug_scope(record)
        scope ? model.where(scope => record.send(scope)) : model.scoped
      end

      def source
        @source ||= self[:source] || %w(name title).detect { |s| model.column_names.include?(s) }
      end
  end
end