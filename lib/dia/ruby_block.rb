module Dia

  class RubyBlock

    require('io/wait') 
    require('stringio') 
    include Dia::SharedFeatures

    attr_reader :stderr
    attr_reader :stdout
    attr_reader :exception

    alias_method :e, :exception

    # @param  [String] Profile Accepts one of five profiles which can be found
    #                          under the {Dia::Profiles} module.
    #
    # @param  [Proc]   Block   Accepts a block or Proc object as its second argument.
    #
    # @raise  [ArgumentError]  It will raise an ArgumentError if a profile and block 
    #                          isn't supplied to the constructor
    #
    # @return [Dia::RubyBlock] Returns an instance of Dia::RubyBlock.
    def initialize(profile, &block)
      raise(ArgumentError, "It is required that a block be passed to the constructor.\n" \
                           "Please consult the documentation.") unless block_given?
      @profile         = profile
      @proc            = block
      @rescue          = false
      @redirect_stdout = false
      @redirect_stderr = false
      @pipes           = {}
    end


    # Provides access to the Standard Output stream of the child process last used to execute
    # your sandbox.  
    # This feature is disabled by default. 
    #
    # @return [String]        Returns the contents of stdout as a String.  
    #
    # @return [nil]           Returns nil when no data is available on stdout.
    #
    # @return [nil]           Returns nil if Dia was not set to redirect stdout before a call
    #                         to {#run} or {#run_nonblock}. 
    #
    # @see #redirect_stdout=  Redirection of stdout can be enabled through #redirect_stdout=
    #
    # @see #redirect_stdout?  #redirect_stdout? can tell you if Standard Output is being 
    #                         redirected.
    #   
    def stdout
      if pipes_readable?(@pipes[:stdout_reader], @pipes[:stdout_writer])
        @pipes[:stdout_writer].close
        @stdout = @pipes[:stdout_reader].read
        @pipes[:stdout_reader].close
      end
      @stdout
    end

    # This method can enable or disable a feature that will capture Standard Output
    # in the child process that is spawned to execute a sandbox.
    #
    # @param  [true]   Enable     Passing true will enable the redirection of Standard Output.
    #
    # @param  [false]  Disable    Passing false will disable the redirection of Standard Output.
    #
    # @return [void]
    #
    # @see    #stdout             Standard Output can be accessed through #stdout.
    #
    # @see    #redirect_stdout?   #redirect_stdout? can tell you if Standard Output is 
    #                             being redirected.
    def redirect_stdout=(boolean)
      @redirect_stdout = boolean
    end

    # This method will tell you if Standard Output is being redirected in the child
    # process spawned to execute your sandbox.
    #
    # @return [true]             Returns true when Standard Output is being redirected.
    #
    # @return [false]            Returns false when Standard Output is not being redirected.
    #
    # @see    #redirect_stdout=  Redirection of stdout can be enabled through #redirect_stdout=.  
    #
    # @see    #stdout            Standard Ouput can be accessed through #stdout.
    def redirect_stdout?
      !!@redirect_stdout
    end

    # Provides access to the Standard Error stream of the child process last used to execute
    # your sandbox.  
    # This feature is disabled by default. 
    #
    # @return [String]       Returns the contents of stderr as a String.
    #
    # @return [nil]          Returns nil when no data is available on stderr.
    # 
    # @return [nil]          Returns nil if Dia was not set to redirect stderr before a call
    #                        to {#run} or {#run_nonblock}. 
    #
    # @see #redirect_stderr= Redirection of stderr can be enabled through #redirect_stderr=
    # 
    # @see #redirect_stderr? #redirect_stderr? can tell you if Standard Error output is being
    #                        redirected.
    def stderr
      if pipes_readable?(@pipes[:stderr_reader], @pipes[:stderr_writer])
        @pipes[:stderr_writer].close
        @stderr = @pipes[:stderr_reader].read
        @pipes[:stderr_reader].close
      end
      @stderr
    end

    # This method can enable or disable a feature that will capture Standard Error output
    # in the child process that is spawned to execute a sandbox.
    #
    # @param  [true]   Enable   Passing true will enable the redirection of Standard Error output.
    #
    # @param  [false]  Disable  Passing false will disable the redirection of Standard Error output.
    #
    # @return [void]
    #
    # @see    #stderr           Standard Error output can be accessed through #stderr.
    #
    # @see    #redirect_stderr? #redirect_stderr? can tell you if Standard Error output is being
    #                           redirected.
    def redirect_stderr=(boolean)
      @redirect_stderr = boolean
    end

    # This method will tell you if Standard Error output is being redirected in the child process
    # used to execute your sandbox.
    # 
    # @return [true]            Returns true when Standard Error output is being redirected.
    #
    # @return [false]           Returns false when Standard Error output is not being redirected.
    #
    # @see    #redirect_stderr= Redirection of stderr can be enabled through #redirect_stderr=.
    #
    # @see    #stderr           Standard Error output can be accessed through #stderr.
    def redirect_stderr?
      !!@redirect_stderr
    end

    # This method will tell you if an exception has been raised in the child process
    # spawned to execute your sandbox.   
    # 
    # @return [true]              Returns true when an exception has been rasied.
    #
    # @return [false]             Returns false when an exception has not been raised.
    #
    # @return [false]             Returns false if Dia was not set to capture exceptions
    #                             before a call to {#run} or {#run_nonblock}. 
    #
    # @see    #rescue_exception=  The capture of exceptions can be enabled or disabled through 
    #                             #rescue_exception=
    #
    # @see    #exception          An exception can be accessed through the #exception 
    #                             method.
    #
    #
    def exception_raised?
      !!exception
    end

    # This method will tell you if an exception raised in the child process used to 
    # spawn your sandbox will be captured/rescued.
    #
    # @return [true]              Returns true when exceptions are being captured.
    #
    # @return [false]             Returns false when are exceptions are not being 
    #                             captured.
    # @since  2.0.0
    #
    # @see    #rescue_exception=  The capture of exceptions can be enabled or disabled through 
    #                             #rescue_exception=
    def rescue_exception?
      !!@rescue
    end

    # This method can enable or disable a feature that will capture/rescue 
    # exceptions that are raised in the child process used to execute your sandbox.
    #
    # @param  [true]   Enable     Passing true will enable the capture of exceptions.
    #
    # @param  [false]  Disable    Passing false will disable the capture of exceptions.
    #
    # @return [void]         
    #
    # @see    #exception          An exception can be accessed through the #exception 
    #                             method.
    # @since 2.0.0
    def rescue_exception=(boolean)
      @rescue = boolean
    end


    # Provides access to the data of an exception object raised in the child process last used to 
    # execute your sandbox.  
    # This feature is disabled by default.  
    # 
    # @return [Dia::ExceptionStruct] Returns an instance of {ExceptionStruct} when an
    #                                exception has been captured.
    # 
    # @return [nil]                  Returns nil when there is no exception available.  
    # 
    # @return [nil]                  Returns nil if Dia was not set to capture exceptions before a
    #                                call to {#run} or {#run_nonblock}. 
    #
    # @see    #rescue_exception=     The capture of exceptions can be enabled or disabled through 
    #                                #rescue_exception=
    #
    # @see    Dia::ExceptionStruct   Dia::ExceptionStruct.
    # @since 1.5
    def exception
      if pipes_readable?(@pipes[:exception_reader], @pipes[:exception_writer]) 
        @pipes[:exception_writer].close
        @e = ExceptionStruct.new *Marshal.load(@pipes[:exception_reader].read).values_at(:klass, 
                                                                                         :message, 
                                                                                         :backtrace)
        @pipes[:exception_reader].close
      end
      @e
    end

    # The run method will spawn a child process and execute the block supplied to the constructor
    # in a sandbox.  
    # This method will block. See {#run_nonblock} for the non-blocking form of
    # this method.
    #
    # @param  [Arguments] Arguments   A variable amount of arguments that will be passed onto the
    #                                 the block supplied to the constructor.
    #
    # @raise  [SystemCallError]       It will raise a number of subclasses of SystemCallError 
    #                                 in a child process if a sandbox violates imposed 
    #                                 restrictions.   
    #
    # @raise  [Dia::SandboxException] It will raise 
    #                                 {Dia::Exceptions::SandboxException}
    #                                 in a child process if it was not possible
    #                                 to initialize a sandbox. 
    #
    # @return [Fixnum]                The Process ID(PID) of the child process used to execute a
    #                                 sandbox.  
    def run(*args)
      launch(*args) 

      # parent ..
      _, @exit_status = Process.wait2(@pid)
      @pid
    end

    # An identical, but non-blocking form of {#run}.
    def run_nonblock(*args)  
      launch(*args)

      @exit_status = Process.detach(@pid)
      @pid
    end

    private
      # @api private
      def launch(*args)
        @e = @stdout = @stderr =  nil
        close_pipes_if_needed
        open_pipes_if_needed

        @pid = fork do
          redirect(:stdout) if @redirect_stdout
          redirect(:stderr) if @redirect_stderr
          if @rescue
            begin
              initialize_sandbox
              @proc.call(*args)
            rescue SystemExit, SignalException, NoMemoryError => e 
              raise(e)
            rescue Exception => e
              begin     
                write_exception(e) 
              rescue SystemExit, SignalException, NoMemoryError => e
                raise(e)
              rescue Exception => e
                write_exception(e)
              end
            ensure
              write_stdout_and_stderr_if_needed
              close_pipes_if_needed
            end
          else
            begin
              initialize_sandbox
              @proc.call(*args)
            ensure
              write_stdout_and_stderr_if_needed
              close_pipes_if_needed
            end
          end
        end
      end

      # @api private
      def write_stdout_and_stderr_if_needed
        if @redirect_stdout
          $stdout.rewind
          @pipes[:stdout_reader].close
          @pipes[:stdout_writer].write($stdout.read)
          @pipes[:stdout_writer].close
        end

        if @redirect_stderr
          $stderr.rewind
          @pipes[:stderr_reader].close
          @pipes[:stderr_writer].write($stderr.read)
          @pipes[:stderr_writer].close
        end
      end

      # @api private
      def close_pipes_if_needed
        @pipes.each do |key, pipe|
          if !pipe.nil? && !pipe.closed?
            pipe.close
          end
        end
      end

      # @api private
      def open_pipes_if_needed
        @pipes[:exception_reader], @pipes[:exception_writer] = IO.pipe if @rescue
        @pipes[:stdout_reader]   , @pipes[:stdout_writer]    = IO.pipe if @redirect_stdout
        @pipes[:stderr_reader]   , @pipes[:stderr_writer]    = IO.pipe if @redirect_stderr
      end

      # @api private
      def write_exception(e)
        @pipes[:exception_writer].write(Marshal.dump({ :klass     => e.class.to_s    ,
                                    :backtrace => e.backtrace.join("\n"),
                                    :message   => e.message.to_s }) )
      end

      # @api private
      def pipes_readable?(reader, writer)
        (reader && writer) && 
        (!reader.closed? && !writer.closed?) && 
        (reader.ready?)
      end

      # @api private
      def redirect(symbol)
        level    = $VERBOSE
        $VERBOSE = nil
        if symbol == :stdout 
          $stdout  = StringIO.new
          Object.const_set(:STDOUT, $stdout)
        else
          $stderr  = StringIO.new
          Object.const_set(:STDERR, $stderr)
        end
        $VERBOSE = level
      end
    
  end

end
