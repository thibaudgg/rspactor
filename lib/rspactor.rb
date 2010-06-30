module RSpactor
  
  autoload :UI,             'rspactor/ui'
  autoload :Interactor,     'rspactor/interactor'
  autoload :Listener,       'rspactor/listener'
  autoload :Inspector,      'rspactor/inspector'
  autoload :Runner,         'rspactor/runner'
  
  class << self
    attr_reader :options, :listener, :runner
    
    def start(options = {})
      @options  = options
      @listener = Listener.new
      @runner   = Runner.new
      Interactor.init_signal_traps
      listener.watch do |files|
        Inspector.determine_spec_paths(files)
        runner.start if Inspector.spec_paths?
      end
      UI.info "RSpactor is now watching at '#{Dir.pwd}'"
      listener.start
    end
    
  end
  
end