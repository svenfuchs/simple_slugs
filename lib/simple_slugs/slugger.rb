require 'active_support/ordered_options'
require 'active_support/core_ext/hash/reverse_merge'

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
      if record.send(slug_name).blank? || !on_blank
        source = record.send(self.source)
        record.slug = ensure_unique_slug(record, source.to_slug) if source
      end
    end

    protected

      def ensure_unique_slug(record, base)
        slug, taken, n = base, self.taken_slugs(record, base), 0
        slug = [base, separator, n += 1].join while taken.include?(slug)
        slug
      end

      def taken_slugs(record, slug)
        scope = translated? ? with_translated_slug(record, slug) : with_slug(record, slug)
        scope.map(&:slug)
      end

      def slug_scope(record)
        scope ? model.where(scope => record.send(scope)) : model.scoped
      end

      def with_slug(record, slug)
        condition = model.arel_table[:slug].matches("#{slug}%")
        slug_scope(record).where(condition)
      end

      def with_translated_slug(record, slug)
        condition = model.translation_class.arel_table[:slug].matches("#{slug}%")
        slug_scope(record) & model.with_translations.where(condition)
      end

      def source
        @source ||= self[:source] || %w(name title).detect { |s| column_names.include?(s) }
      end

      def column_names
        names = model.column_names
        names = names + model.translation_class.column_names if model.respond_to?(:translation_class)
        names
      end

      def translated?
        model.try(:translated?, :slug)
      end
  end
end