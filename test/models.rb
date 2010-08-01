ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define :version => 0 do
  create_table :posts, :force => true do |t|
    t.string :title
    t.string :slug
  end

  create_table :scoped_things, :force => true do |t|
    t.references :scope
    t.string :title
    t.string :slug
  end

  create_table :translated_things, :force => true do |t|
  end

  create_table :translated_thing_translations, :force => true do |t|
    t.references :translated_thing
    t.string :locale
    t.string :title
    t.string :slug
  end
end

class Post < ActiveRecord::Base
  has_slug
end

class ScopedThing < ActiveRecord::Base
  has_slug :scope => :scope_id
end

class TranslatedThing < ActiveRecord::Base
  has_slug
  translates :title, :slug
end