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
    
    suite('Behavior') do

      setup do
        @result          = nil
        @reader, @writer = IO.pipe
      end

      exercise('Confirm the profile ' \
               'Dia::Profiles::NO_INTERNET ' \
               'is creating a working sandbox environment.') do      
        
        sandbox = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
          begin
            @reader.close
            TCPSocket.open('http://www.google.com', 80)
            @writer.write('false')
          rescue SocketError, SystemCallError => e
            @writer.write('true')
          ensure
            @writer.close
          end
        end

        sandbox.run_nonblock
        sleep(1)

        @writer.close
        @result = @reader.gets
        @reader.close
      end

      verify(nil) do
        @result == 'true'
      end

      exercise('Confirm the profile ' \
               'Dia::Profiles::NO_FILESYSTEM_WRITE ' \
               'is creating a working sandbox environment.') do      
        sandbox = Dia::RubyBlock.new(Dia::Profiles::NO_FILESYSTEM_WRITE) do
          begin
            @reader.close
            File.open('/tmp/foo.txt', 'w') { |f| f.puts('fail') }
            @writer.write('false')
          rescue SocketError, SystemCallError => e
            @writer.write('true')
          ensure 
            @writer.close
          end
        end
        

        sandbox.run_nonblock
        sleep(1)

        @writer.close
        @result = @reader.gets
        @reader.close
      end

      verify(nil) do
        @result == 'true'
      end

      exercise('Confirm the profile ' \
               'Dia::Profiles::NO_FILESYSTEM_WRITE_EXCEPT_TMP ' \
               'is creating a working sandbox environment. ') do      
        sandbox = Dia::RubyBlock.new(Dia::Profiles::NO_FILESYSTEM_WRITE_EXCEPT_TMP) do
          begin
            @reader.close
            out = Time.now.to_s
            File.open('/tmp/%s.dia_test' % [ out ] , 'w') { |f| f.puts('success') }
            File.open(File.join(ENV['HOME'], 'fail.txt')) { |f| f.puts('fail') }
            @writer.write('false')
          rescue SocketError, SystemCallError => e
            if File.exists?('/tmp/%s.dia_test' % [ out ])
              @writer.write('true')
            else
              @writer.write('false')
            end
          ensure 
            @writer.close
          end
        end
        
        sandbox.run_nonblock
        sleep(1)

        @writer.close
        @result = @reader.gets
        @reader.close
      end

      verify(nil) do
        @result == 'true'
      end

      exercise('Confirm the profile ' \
               'Dia::Profiles::NO_NETWORKING ' \
               'is creating a working sandbox environment') do
        sandbox = Dia::RubyBlock.new(Dia::Profiles::NO_NETWORKING) do  
          begin
            @reader.close
            TCPSocket.open('http://www.youtube.com', 80)
            @writer.write('false')
          rescue SocketError => e
            @writer.write('true')
          end
        end
        
        sandbox.run_nonblock
        sleep(1)
        
        @writer.close
        @result = @reader.gets
        @reader.close    
      end

      verify(nil) do
        @result == 'true'
      end

      exercise('#run_nonblock called. ') do

        sandbox = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) { }
        @result = sandbox.run_nonblock
      end

      verify('returns the Process ID(PID) of spawned process as a Fixnum') do
        @result.class == Fixnum
      end

    end
  end
end

