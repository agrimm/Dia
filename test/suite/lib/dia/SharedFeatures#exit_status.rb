suite('SharedFeatures') do

  suite('#exit_status') do

    suite('Return values') do
    
      exercise('When #exit_status is called after #run.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { exit(5) }
        dia.run
        @result = dia.exit_status
      end

      verify('#exit_status returns the exit status as a Fixnum') do
        @result == 5
      end

      exercise('When #exit_status is called, and #run is not.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        @result = dia.exit_status
      end

      verify('#exit_status returns nil.') do
        @result == nil
      end

    end

  end

end
