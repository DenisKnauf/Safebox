
module Safebox
	class <<self
		def run *paras, &exe
			exe = paras.shift  unless exe
			box = paras.shift || Class
			Thread.new do
				$SAFE = 4
				this = box.new *paras
				begin
					[:value, String === exe ? this.instance_eval( exe, "Safebox") : this.instance_eval( &exe)]
				rescue Object
					[:exception, $!]
				end
			end.value
		end

		def create_class *paras, &exe
			exe = paras.shift  unless exe
			self.run Class, *paras do
				eval exe
				self
			end
		end
		alias new_class create_class

		def on_exception exc
			$stdout.puts "#{exc} (#{exc.class})\n\t#{exc.backtrace.join"\n\t"}"
		rescue Object
			on_exception $!
		end

		def eval *paras, &exe
			type, value = self.run( *paras, &exe)
			case type
			when :exception  # Really unsecure. Somebody can create an own exception with own #to_s, #class or #backtrace.
				on_exception value
				nil
			when :value  then value
			else # Not possible
			end
		end
		public :eval
	end
end
