require 'safebox/safebox'

class Safebox::Emit
	def initialize db
		@db = db
	end

	def emit key, val
		@db[key] = val
	end

	def inspect
		"#<%s:0x%016x>" % [ self.class, self.object_id ]
	end
end
