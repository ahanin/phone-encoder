class Keymap

    def initialize
        @reverse_map = {}
    end
    
    def self.default
        keymap = Keymap.new
        
        keymap.add 2, 'abc'
        keymap.add 3, 'def'
        keymap.add 4, 'ghi'
        keymap.add 5, 'jkl'
        keymap.add 6, 'mno'
        keymap.add 7, 'pqrs'
        keymap.add 8, 'tuv'
        keymap.add 9, 'wxyz'
        
        keymap
    end
    
    def add (key, symbols)
        symbols.each_char do |sym|
            @reverse_map[sym] = key
        end
    end
    
    def key_for (sym)
        @reverse_map[sym]
    end
    
end