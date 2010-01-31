## "Dia"

"Dia" allows you to sandbox applications on the OSX platform by restricting what access to Operating System resources they can have.  

## What restrictions can you apply?  

* No internet access.
* No network access of any kind.
* No file system writes.
* No file system writes, exlcuding writing to /tmp.
* A complete lockdown of Operating System resources.

## How?
FFI, and the C header "sandbox.h" (found on OSX).

## Example?

	require 'rubygems'
	require 'dia'

	sandbox = Dia::SandBox.new("/Applications/Firefox.app/Contents/MacOS/firefox-bin", Dia::Profiles::NO_INTERNET)
        sandbox.run
        puts "Launched #{sandbox.app_path} with a pid of #{sandbox.pid} using the profile #{sandbox.profile}"

## Install?

Right now, the github repository is where you can install "Dia" from.  
I'll make a gem soon.

## License(MIT)

## License (MIT)  

 Copyright (c) 2009 Robert Gleeson   
  
 Permission is hereby granted, free of charge, to any person  
 obtaining a copy of this software and associated documentation  
 files (the "Software"), to deal in the Software without  
 restriction, including without limitation the rights to use,  
 copy, modify, merge, publish, distribute, sublicense, and/or sell  
 copies of the Software, and to permit persons to whom the  
 Software is furnished to do so, subject to the following  
 conditions:  

 The above copyright notice and this permission notice shall be  
 included in all copies or substantial portions of the Software.  

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,  
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES  
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND  
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT  
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,  
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING  
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR  
 OTHER DEALINGS IN THE SOFTWARE.  
