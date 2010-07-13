module RSpecFormatter
  
  def rspactor_title
    "RSpec results"
  end
  
  def rspactor_message(example_count, failure_count, pending_count, duration)
    message = "#{example_count} examples, #{failure_count} failures"
    if pending_count > 0
      message << " (#{pending_count} pending)"
    end
    message << "\nin #{duration} seconds"
    message
  end
  
  # failed | pending | success
  def rspactor_image_path(failure_count, pending_count)
    icon = if failure_count > 0
      'failed'
    elsif pending_count > 0
      'pending'
    else
      'success'
    end
    File.expand_path(File.dirname(__FILE__) + "/images/#{icon}.png")
  end
  
end