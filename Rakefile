# coding:utf-8
$:.unshift File.expand_path("../lib", __FILE__)

require 'rubygems'
require 'rspactor'
require 'rspactor/version'

def gemspec
  @gemspec ||= begin
    file = File.expand_path('../rspactor.gemspec', __FILE__)
    eval(File.read(file), binding, file)
  end
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = RSpactor::VERSION
  
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "test-gem #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'rake/gempackagetask'
rescue LoadError
  task(:gem) { $stderr.puts '`gem install rake` to package gems' }
else
  Rake::GemPackageTask.new(gemspec) do |pkg|
    pkg.gem_spec = gemspec
  end
  task :gem => :gemspec
end

desc "install the gem locally"
task :install => :package do
  sh %{gem install pkg/rspactor-#{RSpactor::VERSION}}
end

desc "validate the gemspec"
task :gemspec do
  gemspec.validate
end

task :package => :gemspec
task :default => :spec

task :try do
  RSpactor.start
end