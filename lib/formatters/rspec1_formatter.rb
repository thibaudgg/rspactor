require 'spec/runner/formatter/base_formatter'
require 'formatters/rspec_formatter'
require 'rspactor/notifier'

class RSpec1Fromatter < Spec::Runner::Formatter::BaseFormatter
  include RSpecFormatter
  
  def dump_summary(duration, total, failures, pending)
    message    = rspactor_message(total, failures, pending, duration)
    image_path = rspactor_image_path(failures, pending)
    
    RSpactor::Notifier.notify(message, rspactor_title, image_path)
  end
  
end
