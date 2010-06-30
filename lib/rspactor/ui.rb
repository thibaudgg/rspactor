module RSpactor
  module UI
    class << self
      
      def info(message, options = {})
        unless test?
          reset_line if options[:reset]
          clear      if options[:clear]
          puts reset_color(message)
        end
      end
      
      def reset_line
        print "\r\e "
      end
      
    private
      
      def clear
        system("clear;")
      end
      
      def test?
        ENV["RSPACTOR_ENV"] == "test"
      end
      
      def reset_color(text)
        color(text, "\e[0m")
      end
      
      def color(text, color_code)
        "#{color_code}#{text}\e[0m"
      end
      
    end
  end
end
