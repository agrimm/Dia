suite('RubyBlock') do
  
  suite('#redirect_stdout?') do

    suite('Return values') do

      exercise('When stdout is being redirected.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.redirect_stdout = true
        @result = dia.redirect_stdout?
      end

      verify('#redirect_stdout? returns true.') do
        @result == true
      end

      exercise('When stdout is not being redirected.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.redirect_stdout = false
        @result = dia.redirect_stdout?
      end

      verify('#redirect_stdout? returns false.') do
        @result == false
      end
    
    end

  end

end
