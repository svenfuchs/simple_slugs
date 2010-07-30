require File.dirname(__FILE__) + '/test_helper'

class SluggerTest < Test::Unit::TestCase
  test "taken_slugs finds a record with an existing slug (unscoped)" do
    post = Post.new(:slug => 'foo')
    Post.create(:slug => 'foo')
    assert_equal ['foo'], post.slugger.send(:taken_slugs, post, 'foo')
  end

  test "taken_slugs does not find a record with a non-existing slug (unscoped)" do
    post = Post.new(:slug => 'foo')
    Post.create(:slug => 'bar')
    assert_equal [], post.slugger.send(:taken_slugs, post, 'foo')
  end

  test "taken_slugs finds a record with an existing slug (scoped)" do
    thing = ScopedThing.new(:slug => 'foo', :scope_id => 1)
    ScopedThing.create(:slug => 'foo', :scope_id => 1)
    assert_equal ['foo'], thing.slugger.send(:taken_slugs, thing, 'foo')
  end

  test "taken_slugs does not find a record with a non-existing slug (scoped)" do
    thing = ScopedThing.new(:slug => 'foo', :scope_id => 1)
    ScopedThing.create(:slug => 'foo', :scope_id => 1)
    assert_equal ['foo'], thing.slugger.send(:taken_slugs, thing, 'foo')
  end

  test "taken_slugs does not find a record from a different scope (scoped)" do
    thing = ScopedThing.new(:slug => 'foo', :scope_id => 1)
    ScopedThing.create(:slug => 'foo', :scope_id => 2)
    assert_equal [], thing.slugger.send(:taken_slugs, thing, 'foo')
  end
end