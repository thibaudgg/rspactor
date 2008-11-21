require 'osx/cocoa'

class WindowController < OSX::NSWindowController
  ib_outlet :pathTextField, :runButton, :statusBar, :statusLabel
  ib_action :runSpecs
  
  def awakeFromNib
    initAndSetAutomaticPositionAndSizeStoring
    @growlController = GrowlController.alloc.init
    @pathTextField.stringValue = $app.default_from_key(:spec_run_path)
    hook_events
  end
  
  def runSpecs(sender)
    return if SpecRunner.command_running?
    return unless valid_bin_paths?
    path = @pathTextField.stringValue
    return false if path.empty? || !File.exist?(path)
    SpecRunner.run_in_path(path)
  end
  
  def showStatusPanel
    @runButton.enabled = false
    @pathTextField.hidden = true
    @statusBar.hidden = false
    @statusLabel.hidden = false
  end
  
  def showInputPanel
    @runButton.enabled = true
    @pathTextField.hidden = false
    @statusBar.hidden = true
    @statusLabel.hidden = true
  end
  
  def specRunPreparation(notification)
    showStatusPanel
    @statusLabel.stringValue = "Loading environment.. ( #{@pathTextField.stringValue} )"
    @statusBar.indeterminate = true
    @statusBar.startAnimation(self)    
  end
  
  def specRunStarted(notification)
    @statusBar.indeterminate = false
    @statusBar.minValue = 1.0    
    @statusBar.doubleValue = 1.0
    @statusBar.maxValue = notification.userInfo.first
  end
  
  def specRunFinished(notification)
    showInputPanel
  end
  
  def specRunFinishedSingleSpec(notification)
    @statusBar.incrementBy 1.0
    @statusLabel.stringValue = "Running #{$processed_spec_count}...#{$total_spec_count}"
  end
  
  def controlTextDidEndEditing(notification)
    if path_is_valid?(notification.object.stringValue)
      $app.default_for_key(:spec_run_path, notification.object.stringValue)
    end
  end
  
  def relocateDirectoryAndRunSpecs(notification)
    $LOG.debug "relocating and running in.. #{notification.userInfo.first}"
    @pathTextField.stringValue = notification.userInfo.first
    runSpecs(nil)
  end
  
  def initAndSetAutomaticPositionAndSizeStoring
    shouldCascadeWindows = false
    self.window.frameUsingName = 'rspactor_main_window'
    self.window.frameAutosaveName = 'rspactor_main_window'
  end
  
  def resurrectWindow(notification)
    self.window.makeKeyAndOrderFront(self)
  end
  
  def path_is_valid?(path)
    if File.exist?(path)
      @statusLabel.stringValue = ''
      @statusLabel.textColor = OSX::NSColor.colorWithCalibratedRed_green_blue_alpha(0.423077, 0.423077, 0.423077, 1)
      @statusLabel.hidden = true     
      return true
    else
      @statusLabel.stringValue = "- The given path doesn't exist. -"
      @statusLabel.textColor = OSX::NSColor.colorWithCalibratedRed_green_blue_alpha(1.0, 0, 0, 1)
      @statusLabel.hidden = false
      return false
    end    
  end
  
  def valid_bin_paths?
    unless File.exist?($app.default_from_key(:spec_bin_path, ''))
      $app.alert("Cannot find your RSpec executable.", "Please check 'Preferences > Executables > RSpec'.")
      return false
    end
    unless File.exist?($app.default_from_key(:ruby_bin_path, ''))
      $app.alert("Cannot find your Ruby executable.", "Please check 'Preferences > Executables > Ruby'.")
      return false
    end
    if $app.default_from_key(:editor_integration) == '1' && !File.exist?($app.default_from_key(:editor_bin_path, ''))
      $app.alert("Cannot find your editor executable.", "Please check 'Preferences > Editor > Executable'.")
      return false
    end
    true
  end

  def hook_events
    receive :spec_run_invoked,          :specRunPreparation    
    receive :spec_run_start,            :specRunStarted
    receive :spec_run_close,            :specRunFinished
    receive :spec_run_example_passed,   :specRunFinishedSingleSpec
    receive :spec_run_example_pending,  :specRunFinishedSingleSpec
    receive :spec_run_example_failed,   :specRunFinishedSingleSpec
    receive :error,                     :specRunFinished
    receive :relocate_and_run,          :relocateDirectoryAndRunSpecs
    receive :application_resurrected,   :resurrectWindow    
  end    
end
