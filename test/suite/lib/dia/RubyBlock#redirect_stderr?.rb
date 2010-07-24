suite('RubyBlock') do
  
  suite('#redirect_stderr?') do
  
    suite('Return values') do
  
      exercise('#redirect_stderr? will') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.redirect_stderr = true
        @result = dia.redirect_stderr?
      end

      verify('return true when standard error output is being redirected') do
        @result == true
      end

      exercise('#redirect_stderr? will') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.redirect_stderr = false
        @result = dia.redirect_stderr?
      end

      verify('return false when standard error output is not being redirected') do
        @result == false
      end

    end

  end

end
