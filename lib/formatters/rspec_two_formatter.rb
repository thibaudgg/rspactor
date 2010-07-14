require 'rspec/core/formatters/base_formatter'
require "#{File.dirname(__FILE__)}/rspec_formatter"
require "#{File.dirname(__FILE__)}/../rspactor/notifier"

class RSpecTwoFormatter < RSpec::Core::Formatters::ProgressFormatter
  include RSpecFormatter
  
  def dump_summary
    super
    message    = rspactor_message(@example_count, failure_count, pending_count, format_seconds(duration))
    image_path = rspactor_image_path(failure_count, pending_count)
    
    RSpactor::Notifier.notify(message, rspactor_title, image_path)
  end
  
private
  
  def failure_count
    failed_examples.size
  end
  
  def pending_count
    pending_examples.size
  end
  
end