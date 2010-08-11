suite('RubyBlock') do
  suite('#value') do
    suite('Return values') do

      exercise('When #value has finished executing.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          1
        end
        dia.run
        @result = dia.value
      end

      verify('#value returns the return value of the executed block.') do
        @result == "1"
      end

      exercise('When #run or #run_nonblock has not been called.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          1
        end
        @result = dia.value
      end

      verify('#value returns nil.') do
        @result == nil
      end

    end
  end
end
