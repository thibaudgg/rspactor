require 'spec_helper'

describe RSpactor::Runner do
  before(:each) do
    Growl.stub(:installed?).and_return(false)
    RSpactor.stub(:options).and_return({})
  end
  subject { described_class.new }
  
  it "should run all specs" do
    subject.should_receive(:run_rspec).with(
      "bundle exec rspec --color spec",
      "Running all specs"
    )
    subject.start(:all => true)
  end
  
  it "should run without bundler" do
    File.stub!(:exist?).with("./Gemfile").and_return(false)
    subject.should_receive(:run_rspec).with(
      "rspec --color spec",
      "Running all specs"
    )
    subject.start(:all => true)
  end
  
  it "should run Inspector specs_paths" do
    RSpactor::Inspector.stub(:spec_paths).and_return(["spec/models", "spec/runner_spec.rb"])
    subject.should_receive(:run_rspec).with(
      "bundle exec rspec --color spec/models spec/runner_spec.rb",
      "Running: spec/models spec/runner_spec.rb"
    )
    subject.start
  end
  
end
