require 'node'
require 'test/unit'

class TestNode < Test::Unit::TestCase
    
    def test_should_add_node
        assert_not_nil(Node.new.add(2, 'A'))
    end

    def test_should_return_same_node
        root = Node.new
        a_node = root.add(2, 'A')
        
        assert_same(root.add(2, 'A'), a_node)
    end

    def test_should_return_children_by_key
        root = Node.new
        a = root.add(2, 'A')
        b = root.add(2, 'B');

        assert_equal [a, b], root.children_by(2)
    end
    
end
