module Dia


  # The SharedFeatures module implements methods which are shared by 
  # {Dia::Application Dia::Application} and {Dia::RubyBlock Dia::RubyBlock}.  
  # This module shoudln't be interacted with directly. 
  module SharedFeatures
   
    attr_reader :pid

    # @return  [Fixnum]       Returns the Process ID(PID) of the last child process to execute a
    #                         a sandbox.
    #
    # @return  [nil]          Returns nil if #run or #run_nonblock have not been called.
    def pid
      @pid
    end
  
    # The exit_status method will return the exit status of the child process 
    # used to execute a sandbox.      
    # This method blocks until the spawned process exits when being used with #run_nonblock.
    #
    # @return [Fixnum]      Returns the exit status as a Fixnum. 
    #
    # @return [nil]         Returns nil if #run or #run_nonblock have not been called.
    #
    # @since 1.5
    def exit_status()
      unless @exit_status.nil?
        Thread === @exit_status ? @exit_status.value().exitstatus() : 
                                  @exit_status.exitstatus()
      end
    end

    # The terminate method will terminate the child process executing a sandbox.
    #
    # @raise  [SystemCallError] It could raise a number of subclasses of SystemCallError
    #                           if a signal could not be sent to the child process.
    #
    # @return [Fixnum]          Returns 1 when successful.
    #
    # @return [nil]             Returns nil if #run or #run_nonblock has not been called. 
    def terminate()
      ret = Process.kill('SIGKILL', @pid) unless @pid.nil?
      # precaution against the collection of zombie processes.
      _ , @exit_status =  Process.wait2(@pid) if running? 
      ret
    end
    
    # This method can tell you whether the child process used to execute your sandbox is 
    # running or not.
    #
    # @raise  [SystemCallError] It could raise a number of subclasses of SystemCallError
    #                           if a signal could not be sent to the child process.
    #
    # @return [true]            Returns true when the child process is running.
    #
    # @return [false]           Returns false when the child process is not running.
    #
    # @return [nil]             Returns nil if #run or #run_nonblock have not been called.
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
