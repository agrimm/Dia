suite('Application') do
  suite('#initialize') do
    suite('Raises') do
    
      exercise("When the Dia::Profiles::NO_OS_SERVICES profile is supplied to #initialize.") do
        begin
          dia = Dia::Application.new(Dia::Profiles::NO_OS_SERVICES, "touch /tmp/bar") 
        rescue ArgumentError => e
          @result = true
        else
          @result = false
        end
      end

      verify('#initialize will raise an ArgumentError.') do
        @result
      end

    end
  end
end
