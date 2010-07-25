#!/usr/bin/ruby

require 'safebox'

_ = _e = nil
$stdout.print "(0)$ "
db = Safebox.eval { {} }
STDIN.each.each_with_index do |line, i|
	type, value = Safebox.run line, Class.new( Safebox::Box), db, _, _e
	case type
	when :value
		_ = value
		$stdout.puts "=> #{Safebox.eval{value.inspect}}"
	when :exception
		_e = value
		$stdout.puts Safebox.eval{value.inspect}, Safebox.eval{value.backtrace[0..-4].map( &"\t%s".method( :%))}, "\tSafebox:1:in `run'"
	else # Impossible, yet
	end
	$stdout.print "(#{i+1})$ "
end
$stderr.puts "In your db are stored: #{Safebox.eval db.method( :inspect)}"
