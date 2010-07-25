suite('SharedFeatures') do
  suite('#running?') do
    suite('Return values') do
      exercise('When a sandbox is running.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { sleep(50) }
        dia.run_nonblock
        @result = dia.running?
        dia.terminate
      end

      verify('#running? returns true.') do
        @result == true
      end

      exercise('When a sandbox is not running.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.run
        @result = dia.running?
      end

      verify('#running? returns false.') do
        @result == false
      end

      exercise('When #run or #run_nonblock has not been called.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        @result = dia.running?
      end

      verify('#running? returns nil') do
        @result == nil
      end
    
    end
  end
end

