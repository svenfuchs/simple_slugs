# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SlugTest < Test::Unit::TestCase
  include SimpleSlugs
  
  def setup
    I18n.locale = :en
    I18n.backend.store_translations(:de, :i18n => { :transliterate => { :rule => { :'ü' => 'ue' } } })
  end
  
  test "replaces spaces w/ dashes" do
    assert_equal 'foo-bar-baz', Slug.new('foo bar baz')
  end
  
  test "downcases" do
    assert_equal 'foo-bar', Slug.new('Foo Bar')
  end
  
  test "replaces non-wordchar-non-numbers w/ dashes" do
    assert_equal 'foo-bar-baz', Slug.new('foo!bar/baz')
  end
  
  test "strips leading and trailing whitespace" do
    assert_equal 'foo', Slug.new(' foo ')
  end
  
  test "keeps digits" do
    assert_equal 'foo-123', Slug.new('foo 123')
  end
  
  test "strips leading and trailing special chars (1)" do
    assert_equal 'foo-bar', Slug.new('-foo bar-')
  end
  
  test "strips leading and trailing special chars (2)" do
    assert_equal 'foo-bar', Slug.new('_foo bar_')
  end
  
  test "strips leading and trailing special chars (3)" do
    assert_equal 'foo-ba1', Slug.new('!foo ba1')
  end
  
  test "transliterates according to the current locale (:en)" do
    assert_equal 'jurgen-muller', Slug.new('Jürgen Müller')
  end
  
  test "transliterates according to the current locale (:de)" do
    I18n.locale = :de
    assert_equal 'juergen-mueller', Slug.new('Jürgen Müller')
  end
  
  test "strips colons from strings" do
    assert_equal 'foo-bar', Slug.new('foo: bar')
end
end
