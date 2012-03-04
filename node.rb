class Node

    attr_reader :parent, :symbol    

    def initialize (sym = nil, parent = nil)
        @children = {} # children nodes by keypad key
        @symbol = sym
        @parent = parent # parent node
    end
    
    def add (key, sym)
        key_nodes = @children.has_key?(key) ?
            @children[key] :
            @children[key] = {}
        
        key_nodes.has_key?(sym) ?
            key_nodes[sym] :
            key_nodes[sym] = Node.new(sym, self)
    end
    
    def children_by (key)
        @children.has_key?(key) ? @children[key].values : []
    end
    
end