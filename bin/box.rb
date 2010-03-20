#!/usr/bin/ruby

begin
	require 'sbdb'
rescue LoadError
	$stderr.puts "Install sbdb: gem install sbdb"
	exit 1
end
require 'safebox'

_ = _e = nil
Dir.mkdir 'logs' rescue Errno::EEXIST
SBDB::Env.new 'logs', SBDB::CREATE | SBDB::Env::INIT_TRANSACTION do |logs|
	db = logs[ 'test', :type => SBDB::Btree, :flags => SBDB::CREATE]
	db = Safebox::Persistent.new db, db.cursor
	$stdout.print "(0)$ "
	STDIN.each_with_index do |line, i|
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
end
