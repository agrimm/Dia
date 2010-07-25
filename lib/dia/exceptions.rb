module Dia

  # The Exceptions module provides a namespace for exceptions that can be raised by Dia.
  module Exceptions

    # The SandboxException is raised if it is not possible to initialize a sandbox when using
    # {Dia::Application Dia::Application} or {Dia::RubyBlock Dia::RubyBlock}.
    SandboxException = Class.new(StandardError)
  end
end
