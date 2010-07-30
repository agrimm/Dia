module Dia

  # The Application class provides an interface for executing an application in a sandbox.
  class Application
    include Dia::SharedFeatures


    # @param [String] Profile     Accepts one of five profiles found under the {Dia::Profiles} 
    #                             module.
    #
    # @param [String] Application Accepts a path to an application.
    #
    # @raise [ArgumentError]      It isn't possible to launch an application with the 
    #                             {Dia::Profiles::NO_OS_SERVICES} profile, and an ArgumentError will
    #                             be raised if you try to.
    def initialize(profile, app)
      @profile = profile
      @app     = app
      raise(ArgumentError, "It is not possible to launch an application with the " \
                           "Dia::Profiles::NO_OS_SERVICES profile at this time") \
                            if @profile == Dia::Profiles::NO_OS_SERVICES
    end

    # This method will spawn a child process, and execute an application in a sandbox.
    # 
    # @raise  [Dia::Exceptions::SandboxException] It will raise {Dia::Exceptions::SandboxException}
    #                                             in a child process if it is not possible to
    #                                             initialize a sandbox.
    #
    # @return [Fixnum]                            Returns the Process ID of the spawned process.
    def run
      @pid = fork do 
        initialize_sandbox
        exec(@app)
      end

      _, @exit_status = Process.wait2(@pid)
      @pid
    end

    # An identical but non-blocking form of {Dia::Application#run}.
    # @return [Fixnum]
    def run_nonblock
      @pid = fork do
        initialize_sandbox
        exec(@app)
      end

      @exit_status = Process.detach(@pid)
      @pid
    end

  end

end
