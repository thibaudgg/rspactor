require 'sys/uname'
require 'growl'
require 'libnotify'

module RSpactor
  module Notifier
    
    def self.notify(message, title, image_path)
      case Sys::Uname.sysname
      when 'Darwin'
        Growl.notify message, :title => title, :icon => image_path, :name => "RSpactor"
      when 'Linux'
        Libnotify.show :body => message, :summary => title, :icon_path => image_path
      end 
    end
    
  end
end