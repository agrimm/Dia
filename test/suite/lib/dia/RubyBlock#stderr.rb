suite('RubyBlock') do
  suite('#stderr') do
    suite('Return values') do

      setup do
        @result = nil
      end

      exercise('When stderr redirection is enabled, and $stderr is written to.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          $stderr.print('I have been written to.')
        end
        dia.redirect_stderr = true
        dia.run
        @result = dia.stderr
      end
      
      verify('#stderr returns the contents of $stderr as a String.') do
        @result == 'I have been written to.'
      end

      exercise('When stderr redirection is enabled, but $stderr is not written to.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.redirect_stderr = true
        dia.run
        @result = dia.stderr
      end

      verify('#stderr returns nil as no data is available on $stderr.') do
        @result == nil
      end

      exercise('When stderr redirection is disabled, and $stderr is written to.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          $stderr.print "\b"
        end
        dia.redirect_stderr = false # default, but lets be explicit.
        dia.run
        @result = dia.stderr
      end

      verify('#stderr returns nil.') do
        @result == nil
      end

    end
  end
end
