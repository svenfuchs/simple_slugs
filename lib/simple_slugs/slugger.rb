module SimpleSlugs
  class Slugger < ActiveSupport::InheritableOptions
    DEFAULTS = {
      :slug_name => :slug,
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
      if record.send(:read_attribute, slug_name).blank? || !on_blank
        slug = record.send(source).to_slug
        record.slug = ensure_unique_slug(record, slug)
      end
    end
  
    protected
    
      def ensure_unique_slug(record, base)
        slug, taken, n = base, self.taken_slugs(record, base), 0
        slug = [base, separator, n += 1].join while taken.include?(slug)
        slug
      end
    
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