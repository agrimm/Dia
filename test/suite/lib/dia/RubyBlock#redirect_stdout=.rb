suite('RubyBlock') do

  suite('#redirect_stdout=') do

    suite('Return values') do

      exercise('redirect_stdout= returns') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        @a = dia.redirect_stdout = true
        @b = dia.redirect_stdout = false
      end

      verify('its calling argument') do
        @a == true && @b == false
      end


    end
  
  end

end
