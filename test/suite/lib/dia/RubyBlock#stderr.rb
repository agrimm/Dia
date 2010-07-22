suite('RubyBlock') do

  suite('#stderr') do

    setup do
      @result = nil
    end

    exercise('When #redirect_stderr? returns true, and $stderr is written to. ') do
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

    exercise('When #redirect_stderr? returns true, but $stderr is not written to. ') do
      dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
      dia.redirect_stderr = true
      dia.run
      @result = dia.stderr
    end

    verify('#stderr returns nil as no data is available on $stderr.') do
      @result == nil
    end

    exercise('When #redirect_stderr? returns false, and $stderr is written to.') do
      dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
        $stderr.print ''
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
