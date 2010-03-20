require 'safebox/safebox'

class Safebox::Box
	attr_reader :_, :db

	def initialize db, _ = nil
		@_, @db = _, db
	end

	def put key, val
		@db[ key] = val
	end

	def get key
		@db[ key]
	end
end
