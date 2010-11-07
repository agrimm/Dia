# Dia
The **Dia** project can impose restrictions (ie, a sandbox) on a block of Ruby 
code or an OSX application. 

Restrictions are imposed by a OSX API that exists on Mac OSX 10.5 and Mac OSX 10.6.  
If you would like to read more about this API, you can see the manual pages for `sandbox`
and `sandbox_init` but I try to cover what you need to know in the README.


## Profiles
The restrictions imposed by Dia are determined through a **profile**. A profile consists of one or 
more Scheme expressions, but unless you want to write your own profiles, you don't need to worry 
about learning Scheme.

There are five default profiles, some custom profiles(which are part of a private OSX API, and 
subject to change or deletion), and you can even write your own profile if you want to.

At the moment, Dia only supports the five default profiles shipped with OSX, and the restrictions
each profile applies is documented 
[here](http://rubydoc.info/github/robgleeson/Dia/master/Dia/Profiles). 
A profile is always the first argument to
`Dia::RubyBlock.new` or `Dia::Application.new`. All the profiles available to you are found under
the `Dia::Profiles` module.


## Parent => Child 

If you're using `Dia::RubyBlock` or `Dia::Application`, a new child process will always be spawned
to launch your block of ruby code or your application. 

The parent process serves as a "launcher" process, and the child process serves as a sandbox. 
Dia has a lot of convient methods to make communicatiion between the launcher process and the
sandboxed process easier. 

For example, exceptions can be caught and transmitted back to the
launching process, and data from standard output and standard error in the sandboxed process 
can be communicated back to the launching process as well.

## Dia::RubyBlock

`Dia::RubyBlock` is the class responsible for launching a block of ruby code in a 
restricted environment:

      require('rubygems')
      require('dia')
      require('open-uri')

      sandbox = Dia::RubyBlock.new(Dia::Profiles::NO_INTERNET) do
        open('http://www.google.com')
      end

      sandbox.rescue_exception = true 
      sandbox.run

      puts "Exception  : #{sandbox.exception.klass}"
      puts "Message    : #{sandbox.exception.message}"

## Dia::Application

`Dia::Application` is the class responsible for launching an application in a 
restricted environment:

      require('rubygems')
      require('dia')

      sandbox = Dia::Application.new(Dia::Profiles::NO_INTERNET,
                                     '/path/to/firefox')

      sandbox.run_nonblock 
      sandbox.terminate

## Further reading:

* [API Documentation](http://doc.fork-bomb.org/dia)   
  Written using YARD, the API documentation should be your next step.  

* [Mailing list](http://groups.google.com/group/ruby-dia)   
  If you run into any kind of troubles, post to the ML and I'll try to
  help you.

## Supported Rubies

The following Ruby implementations have had the test suite run against them, and
reported a 100% success rate.

* MRI
  * 1.8.7-p299
  * 1.9.1-p378
  * 1.9.2-rc1
  * 1.9.2-p0

* REE
  * Ruby Enterprise Edition 2010.02 (1.8.7-p253)

## MacRuby
MacRuby doesn't support Kernel.fork, and therefore it doesn't work with Dia.  
That shouldn't matter though, since MacRuby 0.7, a "Sandbox" class has been introduced.

It supports loading custom profiles, as well as the default profiles.  
However, it is only possible to impose restrictions for the current(and only) MacRuby process,
which might or might not be desirable :-) Worth the look.


## Contribute
Contributions and collaboration is welcomed with open arms, but before 
you contribute, you should take the time to read the 
[GitPolicy](http://github.com/robgleeson/Dia/blob/master/GitPolicy) and 
[CodingStyle](http://github.com/robgleeson/Dia/blob/master/CodingStyle) files.

## Bugs  
Bug reports are _very_ welcome, and can be reported through the
[issue tracker](http://github.com/robgleeson/dia/issues).


