suite('RubyBlock') do

  suite('#stdout') do

    suite('Return values') do
    
      exercise('When #redirect_stdout? returns true, and $stdout is written to.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          $stdout.print 'Hello!'
        end
        dia.redirect_stdout = true
        dia.run
        @result = dia.stdout
      end

      verify('#stdout returns the contents of stdout as a String') do
        @result == 'Hello!'
      end

      exercise('When #redirect_stdout? returns true, and $stdout is not written to.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        dia.redirect_stdout = true
        @result = dia.stdout
      end

      verify('#stdout returns nil as no data has been written to $stdout') do
        @result == nil
      end

      exercise('When #redirect_stdout? returns false, and $stdout is written to.') do
        dia = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          $stdout.print "\b"
        end
        dia.redirect_stdout = false
        dia.run
        @result = dia.stdout
      end

      verify('#stdout returns nil.') do
        @result == nil
      end

    end

  end

end
