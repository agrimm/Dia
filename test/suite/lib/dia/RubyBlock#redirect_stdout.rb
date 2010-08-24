suite('RubyBlock') do
  suite('#redirect_stdout') do
    suite('Return values') do

      setup do 
        @result = nil
      end

      exercise('When #redriect_stdout= is passed an object.') do
        @dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        @dia.redirect_stdout = "test"
      end

      verify('#redirect_stdout returns that object.') do
        @dia.redirect_stdout == "test"
      end

      exercise('When #redirect_stdout= is not passed an object.') do
        @dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
      end

      verify('#redirect_stdout returns false') do
        @dia.redirect_stdout == false
      end

    end
  end
end

