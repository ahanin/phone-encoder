require 'keymap'
require 'test/unit'

class TestKeymap < Test::Unit::TestCase

    def test_should_return_key_for_symbol
        keymap = Keymap.new
        keymap.add 2, 'abc'
        keymap.add 3, 'def'
        
        assert_equal(keymap.key_for('a'), 2)
        assert_equal(keymap.key_for('b'), 2)
        assert_equal(keymap.key_for('c'), 2)

        assert_equal(keymap.key_for('d'), 3)
        assert_equal(keymap.key_for('e'), 3)
        assert_equal(keymap.key_for('f'), 3)
    end

end