suite('RubyBlock') do
  suite('#exception') do
    suite('Return values') do
      
      exercise('When exceptions are being captured, and an exception is raised.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          raise(StandardError, "raised")
        end

        dia.rescue_exception = true
        dia.run
        @result = dia.exception
      end

      verify('#exception returns a Dia::ExceptionStruct object.') do
        @result.class == Dia::ExceptionStruct
      end

      exercise('When exceptions are being captured, and no exception is raised.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.rescue_exception = true
        dia.run
        @result = dia.exception
      end

      verify('#exception returns nil as no exception is available.') do
        @result == nil
      end

      exercise('When exceptions are not being captured, and an exception is raised.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          raise(StandardError, "raised")
        end
        dia.redirect_stderr  = true  # I don't want the test output to be flooded with a backtrace.
        dia.rescue_exception = false # default, but lets be explicit.
        dia.run
        @result = dia.exception
      end

      verify('#exception returns nil.') do
        @result == nil
      end

    end
  end
end
