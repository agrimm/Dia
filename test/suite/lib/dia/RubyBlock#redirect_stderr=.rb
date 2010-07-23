suite('RubyBlock') do

  suite('#redirect_stderr=') do

    suite('Return Values') do

        exercise('#redirect_stderr= returns') do
          dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
          @a = dia.redirect_stderr = true
          @b = dia.redirect_stderr = false
        end

        verify('its calling argument') do
          @a == true && @b == false
        end

    end
  end
end

