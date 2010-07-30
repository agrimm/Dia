suite('SharedFeatures') do

  suite('#pid') do

    suite('Return values') do

      exercise('When #run has been called.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.run
        @result = dia.pid
      end

      verify('#pid returns the PID of the child process last used to execute a sandbox') do
        @result.class == Fixnum
      end

      exercise('When #run has not been called.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        @result = dia.pid
      end

      verify('#pid returns nil.') do
        @result == nil
      end

    end

  end

end
