require 'growl'

module RSpactor
  class Runner
    attr_reader :pipe
    
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
      @pipe = IO.popen(command)
      UI.info message, :reset => true, :clear => RSpactor.options[:clear]
      while pipe && !pipe.eof?
        if pipe && char = pipe.read(8)
          print char
          $stdout.flush if pipe
        end
      end
      @pipe = nil
    end
    
    def rspec_command(paths)
      cmd_parts = [paths.join(' ')]
      cmd_parts.unshift "--require #{File.dirname(__FILE__)}/../growl/growl_formatter.rb --format GrowlFormatter" if Growl.installed?
      cmd_parts.unshift "--color"
      cmd_parts.unshift "rspec"
      cmd_parts.unshift "bundle exec" if bundler?
      cmd_parts.join(" ")
    end
    
    def bundler?
      File.exist?("./Gemfile")
    end
    
  end
end