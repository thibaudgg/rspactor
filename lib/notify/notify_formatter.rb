require 'rspec/core/formatters/base_formatter'

class NotifyFormatter < RSpec::Core::Formatters::ProgressFormatter
  
  def dump_summary
    super
    failure_count = failed_examples.size
    pending_count = pending_examples.size
    
    icon = if failure_count > 0
      'failed'
    elsif pending_count > 0
      'pending'
    else
      'success'
    end
    
    message = "#{@example_count} examples, #{failure_count} failures"
    if pending_count > 0
      message << " (#{pending_count} pending)"
    end
    message << "\nin #{format_seconds(duration)} seconds"
    
    system("notify-send -i #{image_path(icon)} 'RSpec results' '#{message}'")
  end
  
private
  
  # failed | pending | success
  def image_path(icon)
    File.expand_path(File.dirname(__FILE__) + "/../../images/#{icon}.png")
  end
  
end