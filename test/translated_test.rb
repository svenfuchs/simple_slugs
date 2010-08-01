# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class TranslatedTest < Test::Unit::TestCase
  include SimpleSlugs
  
  test "works with translated source and slug attributes" do
    thing = TranslatedThing.create(:title => 'The title')
    thing.update_attributes(:title => 'Der Titel', :locale => :de)
    
    assert_equal 'The title', thing.title(:en)
    assert_equal 'the-title', thing.slug(:en)

    assert_equal 'Der Titel', thing.title(:de)
    assert_equal 'der-titel', thing.slug(:de)
  end
end