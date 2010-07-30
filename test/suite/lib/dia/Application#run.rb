suite('Application') do
  suite('#run') do
    suite('Return values') do

      exercise('When #run has finished executing.') do
        dia = Dia::Application.new(Dia::Profiles::NO_INTERNET, "touch /tmp/bar")
        @result = dia.run
      end

      verify('It returns the Process ID of the spawned process.') do
        @result.class == Fixnum
      end

    end
  end
end
