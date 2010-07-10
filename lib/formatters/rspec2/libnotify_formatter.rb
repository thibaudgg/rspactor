require 'formatters/rspec2_formatter'
require 'libnotify'

class LibnotifyFormatter < RSpec2Formatter
  
  def dump_summary
    super
    Libnotify.show :body => rspactor_message, :summary => rspactor_title, :icon_path => rspactor_image_path
  end
  
end