require 'rspec/core/formatters/base_formatter'

class RSpec2Formatter < RSpec::Core::Formatters::ProgressFormatter
  
  def rspactor_title
    "RSpec results"
  end
  
  def rspactor_message
    message = "#{@example_count} examples, #{failure_count} failures"
    if pending_count > 0
      message << " (#{pending_count} pending)"
    end
    message << "\nin #{format_seconds(duration)} seconds"
    message
  end
  
  # failed | pending | success
  def rspactor_image_path
    icon = if failure_count > 0
      'failed'
    elsif pending_count > 0
      'pending'
    else
      'success'
    end
    File.expand_path(File.dirname(__FILE__) + "/images/#{icon}.png")
  end
  
private
  
  def failure_count
    failed_examples.size
  end
  
  def pending_count
    pending_examples.size
  end
  
end