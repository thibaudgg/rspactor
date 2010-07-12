require 'formatters/rspec1_formatter'
require 'growl'

class GrowlFormatter < RSpec1Formatter
  
  def dump_summary
    super
    Growl.notify rspactor_message, :title => rspactor_title, :icon => rspactor_image_path
  end
  
end