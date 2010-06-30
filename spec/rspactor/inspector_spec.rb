require 'spec_helper'

describe RSpactor::Inspector do
  subject { described_class }
  
  its(:spec_files) do
    should == [
      "spec/rspactor/inspector_spec.rb",
      "spec/rspactor/listener_spec.rb",
      "spec/rspactor/runner_spec.rb"
    ]
  end
  
  it "should add spec_file to spec_paths" do
    subject.determine_spec_paths(["spec/rspactor/listener_spec.rb"])
    subject.spec_paths.should == ["spec/rspactor/listener_spec.rb"]
  end
  
  it "should uniquify spec_paths" do
    subject.determine_spec_paths(["spec/rspactor/listener_spec.rb", "spec/rspactor/listener_spec.rb"])
    subject.spec_paths.should == ["spec/rspactor/listener_spec.rb"]
  end
  
  describe "/lib" do
    
    it "should translate lib/file to spec/file" do
      Dir.stub(:glob).and_return(["spec/listener_spec.rb"])
      subject.determine_spec_paths(["lib/listener.rb"])
      subject.spec_paths.should == ["spec/listener_spec.rb"]
    end
    
    it "should translate lib/dir/file to spec/dir/file" do
      subject.determine_spec_paths(["lib/rspactor/listener.rb"])
      subject.spec_paths.should == ["spec/rspactor/listener_spec.rb"]
    end
    
    it "should translate lib/file to spec/lib/file" do
      Dir.stub(:glob).and_return(["spec/lib/listener_spec.rb"])
      subject.determine_spec_paths(["lib/listener.rb"])
      subject.spec_paths.should == ["spec/lib/listener_spec.rb"]
    end
    
  end
  
  describe "/app" do
    
    it "should translate app/models/file to spec/models/file" do
      Dir.stub(:glob).and_return(["spec/models/user_spec.rb"])
      subject.determine_spec_paths(["app/models/user.rb"])
      subject.spec_paths.should == ["spec/models/user_spec.rb"]
    end
    
    it "should translate app/views/dir/view_file to spec/views/dir/view_fil" do
      Dir.stub(:glob).and_return(["spec/views/users/show_spec.rb"])
      subject.determine_spec_paths(["app/views/users/show.html.erb"])
      subject.spec_paths.should == ["spec/views/users/show_spec.rb"]
    end
    
  end
  
end
