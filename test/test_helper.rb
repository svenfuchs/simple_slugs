ENV['RAILS_ENV'] = 'test'

require 'rubygems'
require 'test/unit'
require 'fileutils'
require 'logger'
require 'bundler/setup'

require 'test_declarative'
require 'database_cleaner'
require 'active_record'
require 'active_support'
require 'i18n'
require 'globalize'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'simple_slugs'

log = '/tmp/simple_slugs_test.log'
FileUtils.touch(log) unless File.exists?(log)
ActiveRecord::Base.logger = Logger.new(log)
ActiveRecord::LogSubscriber.attach_to(:active_record)
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

DatabaseCleaner.strategy = :truncation

class Test::Unit::TestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

require File.expand_path('../models', __FILE__)
