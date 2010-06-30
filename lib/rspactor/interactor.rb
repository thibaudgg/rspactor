module RSpactor
  module Interactor
    class << self
      
      def init_signal_traps
        # Ctrl-\
        Signal.trap('QUIT') do
          RSpactor.listener.stop
          RSpactor.runner.start(:all => true)
          RSpactor.listener.start
        end
        # Ctrl-C
        Signal.trap('INT') do
          if RSpactor.runner.run?
            UI.info "RSpec run canceled", :reset => true, :clear => RSpactor.options[:clear]
            RSpactor.runner.stop
          else
            UI.info "Bye bye...", :reset => true
            abort("\n")
          end
        end
        # Ctrl-Z
        Signal.trap('TSTP') do
          # UI.info "Reloading Spork...", :reset => true
          RSpactor.listener.stop
          # # Reload Spork
          RSpactor.listener.start
        end
      end
      
    end
  end
end