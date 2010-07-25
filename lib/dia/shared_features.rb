module Dia


  # The SharedFeatures module implements methods which are shared by 
  # {Dia::Application Dia::Application} and {Dia::RubyBlock Dia::RubyBlock}.  
  # This module shoudln't be interacted with directly. 
  module SharedFeatures
    
    # @return  [Fixnum, nil]  Returns the Process ID(PID) of the last child process that was
    #                         used to execute a sandbox.  
    #                         Returns nil if #run or #run_nonblock has not been called yet.
    def pid
      @pid
    end
  
    # The exit_status method will return the exit status of your sandbox.  
    # This method *will* block until the child process(your sandbox) exits
    # when being used with #run_nonblock.
    #
    # @return [Fixnum, nil] Returns the exit status of your sandbox as a 
    #                       Fixnum.  
    #                       Returns nil if #run or #run_nonblock has not
    #                       been called yet.  
    #                       Returns nil if the process hasn't exited yet and 
    #                       #run is being used.
    # @since 1.5
    def exit_status()
      unless @exit_status.nil?
        Thread === @exit_status ? @exit_status.value().exitstatus() : 
                                  @exit_status.exitstatus()
      end
    end

    # The terminate method will send the SIGKILL signal to your sandbox.
    #
    # To prevent the possible accumulation of zombies, this method will 
    # wait to collect the exit status of your sandbox if it doesn't appear 
    # to have left the process table after sending SIGKILL.
    #
    # This is a rare event, and when it does happen #terminate shouldn't block
    # for more than one second.
    #
    # @raise  [SystemCallError] It may raise a number of subclasses of 
    #                           SystemCallError if a call to Process.kill 
    #                           was unsuccessful
    #
    # @return [Fixnum, nil]     Returns 1 when successful.     
    #                           Returns nil if #run or #run_nonblock has not 
    #                           been called yet. 
    def terminate()
      ret = Process.kill('SIGKILL', @pid) unless @pid.nil?
      # precaution against the collection of zombie processes.
      _ , @exit_status =  Process.wait2(@pid) if running? 
      ret
    end
    
    # This method will tell you if your sandbox is still running by returning a boolean.
    #
    # @raise  [SystemCallError] It may raise a number of subclasses of SystemCallError 
    #                           if a signal cannot be sent to the process running 
    #                           a sandbox.
    #
    # @return [Boolean,nil]     Returns true, false, or nil.  
    #                           Returns nil if #run or #run_nonblock has 
    #                           not been called yet.
    def running?()
      if @pid.nil?
        nil
      else
        begin
          Process.kill(0, @pid)
          true
        rescue Errno::ESRCH
          false
        end
      end
    end

    private
    
    # @api private
    def initialize_sandbox
      if Dia::Functions.sandbox_init(FFI::MemoryPointer.from_string(@profile),
                                     0x0001, 
                                     err = FFI::MemoryPointer.new(:pointer)) \
                                     == -1

        raise(Dia::Exceptions::SandboxException, "Failed to initialize sandbox" \
                                                 "(#{err.read_pointer.read_string})")
      end
    end
 
  end

end
