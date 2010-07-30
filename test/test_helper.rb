ENV['RAILS_ENV'] = 'test'

require 'rubygems'
require 'test/unit'
require 'fileutils'
require 'active_record'
require 'active_support'
require 'logger'
require 'pathname_local'
require 'test_declarative'
require 'database_cleaner'
require 'i18n'

$:.unshift Pathname.local('../lib').to_s
require 'simple_slugs'

config = { 'adapter' => 'sqlite3', 'database' => ':memory:' }
ActiveRecord::Base.configurations = { 'test' =>  config }
ActiveRecord::Base.establish_connection(config)

log = '/tmp/simple_slugs_test.log'
FileUtils.touch(log) unless File.exists?(log)
ActiveRecord::Base.logger = Logger.new(log)
ActiveRecord::LogSubscriber.attach_to(:active_record)

DatabaseCleaner.strategy = :truncation

class Test::Unit::TestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

require Pathname.local('models')