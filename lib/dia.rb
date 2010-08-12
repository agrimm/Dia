gem('ffi', '0.6.2')
require('ffi') 
require('ostruct')
require(File.expand_path('dia/shared_features'  , File.dirname(__FILE__)))
require(File.expand_path('dia/functions'        , File.dirname(__FILE__)))
require(File.expand_path('dia/profiles'         , File.dirname(__FILE__)))
require(File.expand_path('dia/ruby_block'       , File.dirname(__FILE__)))
require(File.expand_path('dia/application'      , File.dirname(__FILE__)))
require(File.expand_path('dia/exceptions'       , File.dirname(__FILE__)))
require(File.expand_path('dia/exception_struct' , File.dirname(__FILE__)))

# The Dia module provides a namespace for all classes and modules Dia needs to operate.
module Dia
  VERSION = '2.1.0'
end
