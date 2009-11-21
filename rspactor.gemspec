# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspactor}
  s.version = "0.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mislav Marohni\304\207", "Andreas Wolff", "Pelle Braendgaard", "Thibaud Guillaume-Gentil"]
  s.date = %q{2009-11-21}
  s.default_executable = %q{rspactor}
  s.description = %q{RSpactor is a command line tool to automatically run your changed specs & cucumber features (much like autotest).}
  s.email = %q{thibaud@thibaud.me}
  s.executables = ["rspactor"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     ".rspactor",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/rspactor",
     "images/failed.png",
     "images/pending.png",
     "images/success.png",
     "lib/cucumber_growler.rb",
     "lib/rspactor.rb",
     "lib/rspactor/celerity.rb",
     "lib/rspactor/growl.rb",
     "lib/rspactor/inspector.rb",
     "lib/rspactor/interactor.rb",
     "lib/rspactor/listener.rb",
     "lib/rspactor/runner.rb",
     "lib/rspactor/spork.rb",
     "lib/rspec_growler.rb",
     "spec/inspector_spec.rb",
     "spec/listener_spec.rb",
     "spec/runner_spec.rb"
  ]
  s.homepage = %q{http://github.com/guillaumegentil/rspactor}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{RSpactor is a command line tool to automatically run your changed specs & cucumber features.}
  s.test_files = [
    "spec/inspector_spec.rb",
     "spec/listener_spec.rb",
     "spec/runner_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

