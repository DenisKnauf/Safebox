require 'safebox/emit'

class Safebox::Persistent < Safebox::Emit
	include Enumerable

	def initialize db, cursor
		super db
		@cursor = cursor
	end
	alias put emit
	alias []= emit

	def get key
		@db[ key]
	end
	alias [] get
	alias fetch get

	def each &exe
		exe ? @cursor.each( &exe) : Enumerator.new( self, :each)
	end

	def to_hash
		rh = {}
		each {|key, val| rh[ key] = val }
		rh
	end
end
