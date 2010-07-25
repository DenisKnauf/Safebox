
raise Exception, 'Rubinius does not support $SAFE.  Safebox is useless.'  if Object.const_defined?( :RUBY_ENGINE) and 'rbx' == RUBY_ENGINE

require 'safebox/safebox'
require 'safebox/box'
require 'safebox/emit'
require 'safebox/persistent'
