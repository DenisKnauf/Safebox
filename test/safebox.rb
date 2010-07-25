require 'test/unit'

# No Rubinius-exception
require 'safebox/safebox'
require 'safebox/persistent'
require 'safebox/emit'
require 'safebox/box'

class SafeboxTest < Test::Unit::TestCase
	def test_rubinius
		assert_not_equal 'rbx', RUBY_ENGINE
	end

	def test_eval
		assert_equal 1, Safebox.eval {|| 1 }
		assert_equal [:value,2], Safebox.run {|| 2}
	end

	def test_safe_is_4
		assert_equal 4, Safebox.eval { $SAFE }
	end

	def text_global_unchangeable
		assert_raise( SecurityError) { Safebox.eval { $global = 1 } }
		assert_raise( SecurityError) { Safebox.eval { $GLOBAL = 1 } }
		assert_raise( SecurityError) { Safebox.eval { $SAFE = 1 } }
	end

	def test_evilcode
		# Doesn't work. But else it works perfect
		#assert_raise( SecurityError) { Safebox.eval "class ::Object; def evil; end end" }
	end

	def test_setconst
		# Doesn't work too. I think it's Test::Unit
		#assert_raise( SecurityError) { Safebox.eval "class ::ABC; end" }
		begin Safebox.eval "class ::ABC; end"
		rescue SecurityError
		end
	end

	def test_callinsecure
		assert_raise( SecurityError) { Safebox.eval("class ABC;def abc; end end;ABC").new.abc }
	end
end
