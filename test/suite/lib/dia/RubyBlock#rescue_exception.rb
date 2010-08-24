suite('RubyBlock') do
  suite('#rescue_exception') do
    suite('Return values') do

      setup do 
        @result = nil
      end

      exercise('When #rescue_exception= is passed an object.') do
        @dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        @dia.rescue_exception = "test"
      end

      verify('#rescue_exception returns that object.') do
        @dia.rescue_exception == "test"
      end

      exercise('When #rescue_exception= is not passed an object.') do
        @dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
      end

      verify('#rescue_exception returns false') do
        @dia.rescue_exception == false
      end

    end
  end
end
