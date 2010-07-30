suite('RubyBlock') do  
  suite('#redirect_stderr?') do
    suite('Return values') do
  
      exercise('When stderr output is being redirected.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.redirect_stderr = true
        @result = dia.redirect_stderr?
      end

      verify('#redirect_stderr? returns true.') do
        @result == true
      end

      exercise('When stderr output is not being redirected.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.redirect_stderr = false
        @result = dia.redirect_stderr?
      end

      verify('#redirect_stderr? returns false.') do
        @result == false
      end

    end
  end
end
