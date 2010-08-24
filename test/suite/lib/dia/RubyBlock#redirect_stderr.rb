suite('RubyBlock') do
  suite('#redirect_stderr') do
    suite('Return values') do

      setup do 
        @result = nil
      end

      exercise('When #redriect_stderr= is passed an object.') do
        @dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        @dia.redirect_stderr = "test"
      end

      verify('#redirect_stderr returns that object.') do
        @dia.redirect_stderr == "test"
      end

      exercise('When #redirect_stderr= is not passed an object.') do
        @dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
      end

      verify('#redirect_stderr returns false') do
        @dia.redirect_stderr == false
      end

    end
  end
end

