require 'rspec/core/formatters/base_formatter'
require "#{File.dirname(__FILE__)}/rspec_formatter"
require "#{File.dirname(__FILE__)}/../rspactor/notifier"

class RSpecTwoFormatter < RSpec::Core::Formatters::ProgressFormatter
  include RSpecFormatter
  
  def dump_summary(duration, total, failures, pending)
    super # needed to keep progress formatter
    message    = rspactor_message(total, failures, pending, duration)
    image_path = rspactor_image_path(failures, pending)
    
    RSpactor::Notifier.notify(message, rspactor_title, image_path)
  end
  
end