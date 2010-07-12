require 'formatters/rspec1_formatter'
require 'libnotify'

class LibnotifyFormatter < RSpec1Formatter
  
  def dump_summary
    super
    Libnotify.show :body => rspactor_message, :summary => rspactor_title, :icon_path => rspactor_image_path
  end
  
end