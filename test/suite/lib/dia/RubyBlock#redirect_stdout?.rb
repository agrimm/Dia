suite('RubyBlock') do
  
  suite('#redirect_stdout?') do

    suite('Return values') do

      exercise('#redirect_stdout? will') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.redirect_stdout = true
        @result = dia.redirect_stdout?
      end

      verify('return true when standard output is being redirected') do
        @result == true
      end

      exercise('#redirect_stdout? will') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.redirect_stdout = false
        @result = dia.redirect_stdout?
      end

      verify('return false when standard output is not being redirected') do
        @result == false
      end
    
    end

  end

end
