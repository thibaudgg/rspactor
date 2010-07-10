require 'formatters/rspec2_formatter'
require 'growl'

class GrowlFormatter < RSpec2Formatter
  
  def dump_summary
    super
    Growl.notify rspactor_message, :title => rspactor_title, :icon => rspactor_image_path
  end
  
end