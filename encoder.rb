class Encoder

    def initialize (dict)
        @dict = dict
    end
    
    def for_each_in (io, &callback)
        io.each { |line|
            number = line.rstrip
            digits = []
            number.scan( /\d/ ) do |c|
                digits << c.to_i
            end

            if !digits.empty? then
                encode_number callback, number, digits
            end
        }
    end
    
    private 
    
    def encode_number (callback, number, digits,
                                        string_so_far = "", left = 0, right = digits.length,
                                        words_found = 0, last_was_digit = false)
        (left..digits.length).each do |left_bound|
            digits.length.downto(left_bound + 1) do |right_bound|
                words = @dict.find_words(digits, left_bound, right_bound)
                words.each do |word|
                    next_string =  string_so_far + (left_bound > 0 ? '-' : '' ) + word
                    encode_number callback, number, digits, next_string, left_bound + word.length, digits.length, words_found + 1
                end
            end
            
            if left_bound > 0 && !last_was_digit then
                string_so_far += '-'
            end
            
            string_so_far += digits[left_bound].to_s
            last_was_digit = true
            
        end
        
        if words_found > 0 then
            callback.call number, string_so_far
        end
    end

end
