suite('RubyBlock') do
  suite('#exception_rescued?') do
    suite('Return values') do
   
      exercise('When an exception has been rescued.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          raise(StandardError, "raised") 
        end
        dia.rescue_exception = true
        dia.run
        @result = dia.exception_rescued?
      end

      verify('#exception_rescued? returns true.') do
        @result == true
      end

      exercise('When an exception has not been raised.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.rescue_exception = true
        dia.run
        @result = dia.exception_rescued?
      end

      verify('#exception_rescued? returns false.') do
        @result == false
      end

      exercise('When exceptions are not being captured, and an exception has been raised.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          raise(StandardError, "raised")
        end
        dia.rescue_exception = false # default, but lets be explicit.
        dia.redirect_stderr = true   # I don't want the tests to be flooded with a backtrace.
        dia.run
        @result = dia.exception_rescued?
      end

      verify('#exception_rescued? returns false') do
        @result == false
      end

    end
  end
end
