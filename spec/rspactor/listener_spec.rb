require 'spec_helper'

describe RSpactor::Listener do
  subject { described_class.new }
  
  its(:last_event) { should < Time.now }
  
end