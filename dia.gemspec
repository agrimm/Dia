# -*- encoding: utf-8 -*-
require('./lib/dia')

Gem::Specification.new do |s|

  s.name    = %q{dia}
  s.version = Dia::VERSION
  s.authors = ["Robert Gleeson"]
  s.email   = %q{rob@flowof.info}
  s.date    = Time.now.strftime("%Y-%m-%d")
  
  s.description = %q{Through the use of technology found on Apple's Leopard and Snow Leopard 
                     operating systems, Dia can create dynamic and robust sandbox environments 
                     for applications and for blocks of ruby code. 
                     The Ruby API was designed to be simple, and a joy to use. 
                     I hope you feel the same way :-)}

  s.summary     = %q{Through the use of technology found on Apple's Leopard and Snow Leopard 
                     operating systems, Dia can create dynamic and robust sandbox environments 
                     for applications and for blocks of ruby code. 
                     The Ruby API was designed to be simple, and a joy to use. 
                     I hope you feel the same way :-)}

 
  s.require_paths = ["lib"]
  s.files         = Dir["lib/**/*.rb"] + Dir["test/**/*.rb"] + %w(COPYING README.mkd dia.gemspec)
  s.test_files    = Dir["test/**/*.rb"]
  

  s.add_runtime_dependency(%q<ffi>, ["= 0.6.2"])
  s.add_development_dependency(%q<yard>, [">= 0"])
  s.has_rdoc = %q{yard}

  s.post_install_message = <<-MESSAGE  
  -------------------------------------------------------------------------------- 
  Dia (#{Dia::VERSION})
  
  Thanks for installing Dia, #{Dia::VERSION}! 

  The >=2.0.0 releases are not backward compatiable with the 1.0 series.

  Details of this release can be read at the mailing list:
  http://groups.google.com/group/ruby-dia/browse_thread/thread/fc255eeee8c59eeb
 
  [Github]             http://github.com/robgleeson/dia
  [API Documentation]  http://yardoc.org/docs/robgleeson-dia/
  --------------------------------------------------------------------------------  
  MESSAGE

end
