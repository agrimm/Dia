suite('SharedFeatures') do
  suite('#terminate') do
    suite('Return values') do
   
      exercise('When #terminate terminates a sandbox.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { sleep(10) }
        dia.run_nonblock
        @result = dia.terminate
      end

      verify('#terminate returns 1.') do
        @result == 1
      end

      exercise('When #run or #run_nonblock has not been called.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        @result = dia.terminate
      end

      verify('#terminate returns nil.') do
        @result == nil
      end

    end
  end
end
