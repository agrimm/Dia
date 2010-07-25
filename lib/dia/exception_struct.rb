
module Dia

 # The instance methods available on this class represent data extracted from an Exception-derived
 # object.   
 # An instance of this class is returned by {Dia::RubyBlock#exception Dia::RubyBlock#exception}.  
 # This class shouldn't be initialized directly by you.
 #
 # @attr_reader [String] klass     Returns Exception#class as a String.
 # @attr_reader [String] message   Returns Exception#message as a String.
 # @attr_reader [String] backtrace Returns Exception#backtrace as a String.
 class ExceptionStruct < Struct.new(:klass, :message, :backtrace)
 end
end
