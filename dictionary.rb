require 'node'
require 'keymap'

class Dictionary

    def initialize (keymap)
        @words_by_length = {}
        @keymap = keymap
    end

    def self.load_from (file_name, keymap = Keymap.default)
        dict = Dictionary.new(keymap)
        
        File.open(file_name, "r") do |file|
            file.each { |line|
                dict.add line.rstrip # removing trailing \n's
            }
        end
        
        dict        
    end
    
    def add (*words)
        words.each do |word|
            length = word.length
            node = @words_by_length.has_key?(length) ?
                @words_by_length[length] :
                @words_by_length[length] = Node.new
                
            word.each_char do |sym|
                key = @keymap.key_for sym
                node = node.add key, sym
            end
        end
    end
    
    def find_words (keys, left = 0, right = keys.length)
        length = right - left
        
        if left + length > keys.length || !@words_by_length.has_key?(length) then
            []
        else 
            find_words_internal(keys, left, right, 0, @words_by_length[length], [])
        end
    end
    
    private
    
    def find_words_internal (keys, left, right, pos, node, words_so_far)
        abs_pos = left + pos
        
        if abs_pos < right then
            key = keys[abs_pos]
            node.children_by(key).each do |child|        
                find_words_internal keys, left, right, pos + 1, child, words_so_far
            end
        else
            # build word only when match is found
            string = []
            begin
                string << node.symbol
                node = node.parent
            end while node.parent
            
            words_so_far << string.join.reverse # reverse, as we go bottom-up            
        end
        
        words_so_far
    end
    
end
