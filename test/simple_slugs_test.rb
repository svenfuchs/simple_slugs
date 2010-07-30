require File.dirname(__FILE__) + '/test_helper'

class SimpleSlugsTest < Test::Unit::TestCase
  def setup
    Post.slugger.on_blank = true
  end

  test "sets slug from slug source" do
    post = Post.create(:title => 'from title')
    assert_equal 'from-title', post.slug
  end

  test "does not overwrite an explicitely set slug" do
    post = Post.create(:title => 'from title', :slug => 'the-slug')
    assert_equal 'the-slug', post.slug
  end

  test "overwrites a present slug if :on_blank is false" do
    Post.slugger.on_blank = false
    post = Post.create(:title => 'not updated')
    post.update_attributes(:title => 'updated')
    assert_equal 'updated', post.slug
  end

  test "does not overwrite a present slug if :on_blank is true" do
    post = Post.create(:title => 'not updated')
    post.update_attributes(:title => 'updated')
    assert_equal 'not-updated', post.slug
  end

  test "can explicitely overwrite a present slug" do
    post = Post.create(:title => 'from title')
    post.update_attributes(:slug => 'the-slug')
    assert_equal 'the-slug', post.slug
  end

  test "creates a unique slug by appending --n (unscoped)" do
    Post.create(:slug => 'foo')
    Post.create(:slug => 'foo-1')
    post = Post.create(:title => 'foo')
    assert_equal 'foo-2', post.slug
  end

  test "creates a unique slug by appending --n (scoped)" do
    ScopedThing.create(:slug => 'foo', :scope_id => 1)
    ScopedThing.create(:slug => 'foo-1', :scope_id => 1)
    thing = ScopedThing.create(:title => 'foo', :scope_id => 1)
    assert_equal 'foo-2', thing.slug
  end

  test "does not append --n to a slug that is part of an existing slug" do
    Post.create(:slug => 'foo-bar')
    post = Post.create(:title => 'foo')
    assert_equal 'foo', post.slug
  end

  test "works on repeated saves" do
    post = Post.create(:title => 'foo')
    5.times { post.save! }
    assert_equal 'foo', post.slug
  end
end
