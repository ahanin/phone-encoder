require 'dictionary'
require 'keymap'
require 'test/unit'

class TestDictionary < Test::Unit::TestCase

    def test_should_find_words
        dict = Dictionary.new(Keymap.default)
        dict.add "key", "lex", "dog", "god"
        
        words = dict.find_words [5, 3, 9], 0, 3
        
        assert_equal ["key", "lex"], words
    end

end
