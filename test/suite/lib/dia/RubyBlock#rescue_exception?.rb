suite('RubyBlock') do

  suite('#rescue_exception?') do
 
    suite('Return values') do 

      exercise('When exceptions are being captured.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.rescue_exception = true
        @result = dia.rescue_exception?
      end

      verify('#rescue_exception? returns true') do
        @result == true
      end

      exercise('When exceptions are not being captured.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.rescue_exception = false # default, but lets be explicit.
        @result = dia.rescue_exception?
      end

      verify('#rescue_exception? returns false') do
        @result == false
      end

    end

  end

end

