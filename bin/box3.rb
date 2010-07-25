#!/usr/bin/ruby

require 'safebox'

_ = _e = nil
$stdout.print "(0)$ "
db = Safebox.run { {} }
STDIN.each.each_with_index do |line, i|
	ret = Safebox.run line, Class.new( Safebox::Box), db, _, _e
	if :value == ret.first
		_ = ret.last
		$stdout.puts "=> #{ret.last.inspect}"
	else
		_e = ret.last
		$stdout.puts ret.last.inspect, ret.last.backtrace[0..-4].map( &"\t%s".method( :%)), "\tSafebox:1:in `run'"
	end
	$stdout.print "(#{i+1})$ "
end
