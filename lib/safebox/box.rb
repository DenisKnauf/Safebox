require 'safebox/safebox'

class Safebox::Box
	attr_reader :_, :db

	def initialize db, _ = nil, _e = nil
		@_, @db, @_e = _, db, _e
	end

	def _!
		@_e
	end

	def put key, val
		@db[ key] = val
	end

	def get key
		@db[ key]
	end
end
