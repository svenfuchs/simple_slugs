# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'simple_slugs/version'

Gem::Specification.new do |s|
  s.name         = "simple_slugs"
  s.version      = SimpleSlugs::VERSION
  s.authors      = ["Sven Fuchs"]
  s.email        = "svenfuchs@artweb-design.de"
  s.homepage     = "http://github.com/svenfuchs/simple_slugs"
  s.summary      = "Simple slugs for ActiveRecord"
  s.description  = "Simple slugs for ActiveRecord."

  s.files        = Dir.glob("lib/**/**")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  s.add_dependency 'activerecord', '~> 3.0.3'
  s.add_dependency 'i18n'

  s.add_development_dependency 'test_declarative'
  s.add_development_dependency 'database_cleaner', '0.5.2'
  s.add_development_dependency 'sqlite3-ruby'
  s.add_development_dependency 'globalize3'
end
