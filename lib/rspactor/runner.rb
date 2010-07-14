module RSpactor
  class Runner
    attr_reader :pipe, :rspec_version
    
    def initialize
      @rspec_version = RSpactor.options[:rspec_version] || determine_rspec_version
    end
    
    def start(options = {})
      if options[:all]
        command = rspec_command(["spec"])
        message = "Running all specs"
      else
        command = rspec_command(Inspector.spec_paths)
        message = "Running: #{Inspector.spec_paths.join(' ') }"
      end
      run_rspec(command, message)
    end
    
    def stop
      Process.kill("ABRT", pipe.pid)
      @pipe = nil
    end
    
    def run?
      pipe && pipe.pid != nil
    end
    
  private
    
    def run_rspec(command, message)
      UI.info message, :reset => true, :clear => RSpactor.options[:clear]
      case rspec_version
      when 1
        # problem with color if launched via popen
        system(command)
      when 2
        @pipe = IO.popen(command)
        while pipe && !pipe.eof?
          if pipe && char = pipe.read(32)
            print char
            $stdout.flush if pipe
          end
        end
        @pipe = nil
      end
    end
    
    def rspec_command(paths)
      cmd_parts = []
      cmd_parts << (rspec_version == 1 ? "spec" : "rspec")
      cmd_parts << "--color"
      if growl_installed? || notify_installed?
        case rspec_version
        when 1
          cmd_parts << "-f progress --require #{File.dirname(__FILE__)}/../formatters/rspec_one_formatter.rb --format RSpecOneFormatter:STDOUT"
        when 2
          cmd_parts << "--require #{File.dirname(__FILE__)}/../formatters/rspec_two_formatter.rb --format RSpecTwoFormatter"
        end
      end
      cmd_parts << paths.join(' ')
      cmd_parts.unshift "bundle exec" if bundler?
      cmd_parts.join(" ")
    end
    
    def bundler?
      File.exist?("#{Dir.pwd}/Gemfile")
    end
    
    def determine_rspec_version
      UI.info "Determine rspec_version... (can be forced with -r <i> option)"
      if bundler?
        # Allow RSpactor to be tested with RSpactor (bundle show inside a bundle exec)
        ENV['BUNDLE_GEMFILE'] = "#{Dir.pwd}/Gemfile"
        `bundle show rspec`.include?("/rspec-1.") ? 1 : 2
      elsif File.exist?("#{Dir.pwd}/spec/spec_helper.rb")
        File.new("#{Dir.pwd}/spec/spec_helper.rb").read.include?("Spec::Runner") ? 1 : 2
      else
        2
      end
    end
    
    def growl_installed?
      system 'which growlnotify > /dev/null 2>&1'
    end
    
    def notify_installed?
      system 'which notify-send > /dev/null 2>&1'
    end
    
  end
end