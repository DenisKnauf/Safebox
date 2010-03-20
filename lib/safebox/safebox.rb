
module Safebox
	def self.run *paras, &exe
		exe = paras.shift  unless exe
		box = paras.shift || Class
		Thread.new do
			$SAFE = 4
			this = box.new *paras
			begin
				[:value, this.instance_eval( exe, "Safebox")]
			rescue Object
				[:exception, $!]
			end
		end.value
	end

	def self.create_class *paras, &exe
		exe = paras.shift  unless exe
		run Class, *paras do
			eval exe
			self
		end
	end
	alias new_class create_class
end
