# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'rspactor/version'

Gem::Specification.new do |s|
  s.name        = "rspactor"
  s.version     = RSpactor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Thibaud Guillaume-Gentil"]
  s.email       = ["thibaud@thibaud.me"]
  s.homepage    = "http://github.com/thibaudgg/rspactor"
  s.summary     = "Simpler Autotest"
  s.description = "RSpactor is a command line tool to automatically run your changed specs (much like autotest)"
  
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "rspactor"
  
  s.add_development_dependency  'bundler', '>= 1.0.0.rc.5'
  s.add_development_dependency  'rspec',   '>= 2.0.0.beta.17'
  
  s.add_dependency 'bundler',   '>= 1.0.0.rc.5'
  s.add_dependency 'trollop',   '>= 1.16.2'
  s.add_dependency 'sys-uname', '>= 0.8.4'
  # Mac OS X
  s.add_dependency 'growl',     '>= 1.0.3'
  # Linux
  s.add_dependency 'rb-inotify'
  s.add_dependency 'libnotify', '>= 0.1.3'
  
  s.files        = Dir.glob("{bin,images,lib,ext}/**/*") + %w[LICENSE README.rdoc]
  s.extensions   = ["ext/extconf.rb"]
  s.executable   = 'rspactor'
  s.require_path = 'lib'
end
