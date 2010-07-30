suite('RubyBlock') do
  suite('#run_nonblock') do
    suite('Return values') do

      exercise('When #run_nonblock has finished executing.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        @result = dia.run_nonblock
      end

      verify('It will return the PID of the child process used to execute a sandbox.') do
        @result.class == Fixnum
      end

    end
  end
end

