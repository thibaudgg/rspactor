require 'spec_helper'

describe RSpactor::Runner do
  before(:each) { @pwd = Dir.pwd }
  let(:runner) { init_runner }
  
  context "with RSpec 2.0" do
    before(:each) { runner.stub(:rspec_version).and_return(2) }
    
    it "should run all specs" do
      runner.should_receive(:run_rspec).with(
        "bundle exec rspec --color spec",
        "Running all specs"
      )
      runner.start(:all => true)
    end
    
    it "should run without bundler" do
      File.stub!(:exist?).with("#{@pwd}/Gemfile").and_return(false)
      runner.should_receive(:run_rspec).with(
        "rspec --color spec",
        "Running all specs"
      )
      runner.start(:all => true)
    end
    
    it "should run Inspector specs_paths" do
      RSpactor::Inspector.stub(:spec_paths).and_return(["spec/models", "spec/runner_spec.rb"])
      runner.should_receive(:run_rspec).with(
        "bundle exec rspec --color spec/models spec/runner_spec.rb",
        "Running: spec/models spec/runner_spec.rb"
      )
      runner.start
    end
    
  end
  
  context "/spec/fixtures/bundler_rspec1" do
    before(:each) { Dir.stub(:pwd).and_return(@pwd + '/spec/fixtures/bundler_rspec1') }
    
    it "should get rspec 1 version from Gemfile" do
      runner.should_receive(:system).with("bundle exec spec --color spec")
      runner.start(:all => true)
    end
    
    it "should force rspec 2 version from options" do
      runner = init_runner(:rspec_version => 2)
      IO.should_receive(:popen).with("bundle exec rspec --color spec")
      runner.start(:all => true)
    end
  end
  
  context "/spec/fixtures/bundler_rspec2" do
    before(:each) { Dir.stub(:pwd).and_return(@pwd + '/spec/fixtures/bundler_rspec2') }
    
    it "should get rspec 2 version from Gemfile" do
      IO.should_receive(:popen).with("bundle exec rspec --color spec")
      runner.start(:all => true)
    end
  end
  
  context "/spec/fixtures/helper_rspec1" do
    before(:each) { Dir.stub(:pwd).and_return(@pwd + '/spec/fixtures/helper_rspec1') }
    
    it "should get rspec 1 version from spec_helper" do
      runner.should_receive(:system).with("spec --color spec")
      runner.start(:all => true)
    end
  end
  
  context "/spec/fixtures/unknown_rspec_version" do
    before(:each) { Dir.stub(:pwd).and_return(@pwd + '/spec/fixtures/unknown_rspec_version') }
    
    it "should get rspec 2 version when dertermination failed" do
      IO.should_receive(:popen).with("rspec --color spec")
      runner.start(:all => true)
    end
  end

protected
  
  def init_runner(rspactor_options = {})
    RSpactor.stub(:options).and_return(rspactor_options)
    runner = described_class.new
    runner.stub(:growl_installed?).and_return(false)
    runner.stub(:notify_installed?).and_return(false)
    runner
  end
  
end
