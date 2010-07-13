# -*- encoding: utf-8 -*-
require 'rspactor/version'
require 'bundler'

Gem::Specification.new do |s|
  s.name        = "rspactor"
  s.version     = RSpactor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Thibaud Guillaume-Gentil"]
  s.email       = ["thibaud@thibaud.me"]
  s.homepage    = "http://github.com/thibaudgg/rspactor"
  s.summary     = "Simpler Autotest"
  s.description = "RSpactor is a command line tool to automatically run your changed specs (much like autotest)"
  
  s.required_rubygems_version = ">= 1.3.7"
  s.add_bundler_dependencies
  
  s.files        = Dir.glob("{bin,images,lib,ext}/**/*") + %w[LICENSE README.rdoc]
  s.extensions   = ["ext/extconf.rb"]
  s.executable   = 'rspactor'
  s.require_path = 'lib'
end