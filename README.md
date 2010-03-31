Install
=======

	gem install Safebox

Usage
=====

First load the safebox:

	require 'safebox'

The most things in your Safebox are possible:

	value = Safebox.eval "1+2**9"
	value = Safebox.eval {|| 1+2**8 }

Only some good things are not possible:

	Safebox.eval "$stdout.puts 'I am OK!'"

But, very bad code will not damage your system.

	Safebox.eval "class Unsecure;def self.code() system 'rm *' ; end end; Unsecure.code"

This will raise a SecurityError.

What is with raised exceptions?

	Safebox.eval "raise Exception"

This will print the Exception.

Or if you want to get the Exception:

	ret = Safebox.run "raise Exception"
	ret # => [:exception, #<Exception>]

What is *Safebox.run*?

	ret = Safebox.run "1+2**9"
	ret # => [:value, 513]

You get something back, which can be unsafe!

	Safebox.eval( "class A;def to_s() 'Owned!'; end end; A.new").to_s
	puts Safebox.eval( "class A;def to_s() 'Owned!'; end end; A.new")
