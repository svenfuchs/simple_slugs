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

  s.files        = `git ls-files {app,lib}`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
end
