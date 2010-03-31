Requires
========

Ruby MRI or Ruby 1.9.

Will not work with Rubinius! It does not support $SAFE.

I do not know JRuby.

Install
=======

	gem install Safebox

Usage
=====

First load the safebox:

	#! ruby
	require 'safebox'

The most things in your Safebox are possible:

	value = Safebox.eval "1+2**9"  # => 513
	value = Safebox.eval {|| 1+2**8 }  # => 257

You can use a String or a Proc,  also as argument:

	value = Safebox.eval lambda {|| 1+2**7 }

More complex code with classes and everything else...

	value = Safebox.eval do
		class Mail
			attr_accessor :subject, :body, :to, :from
			def generate
				[ "To: #{@to}", "From: #{@from}",
					"Subject: #{@subject}", '', @body ].join "\n"
			end
		end
		mail = Mail.new
		mail.from, mail.to, mail.subject = "me", "root", "Plz install Ruby :)"
		mail.subject = "..."
		mail.generate
	end

Only some good things are not possible:

	Safebox.eval "$stdout.puts 'I am OK!'"  # not possible :(

But, very bad code will not damage your system.

	Safebox.eval "class Unsecure;def self.code() system 'rm *' ; end end; Unsecure.code"  # will fail :)

This will raise a SecurityError.

What is with raised exceptions,  like SecurityError or others?

	Safebox.eval "raise Exception"

This will print the Exception to Console.

You want to get the Exception?

	ret = Safebox.run "raise Exception"
	ret # => [:exception, #<Exception>]

What is *Safebox.run*?

	ret = Safebox.run "1+2**9"
	ret # => [:value, 513]

It returns the value or the raised exception.  --  Nothing else.

You should know,  Ruby is not stupid.  I am very surprised,
because this is not possible:

	aA = Safebox.eval do
		class A
			def to_s
				'Owned!'
			end
		end
		A.new
	end
	aA.to_s  # => SecurityError: calling insecure method: to_s

*A#to_s* is defined in our *Safebox*,  so every call outside can be a security hole.

But you can use #to_s in an other Safebox, withour any risk:

	Safebox.eval aA.method( :to_s)  # => "Owned!"  # Not really :)

Behind Safebox
==============

It uses only a Thread,  $SAFE=4 and  some code for automatism.

The real magic is Ruby itself.
