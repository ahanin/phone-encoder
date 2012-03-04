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
        while left < digits.length
            while right > left
                words = @dict.find_words(digits, left, right)
                words.each do |word|
                    next_string =  string_so_far + (left > 0 ? '-' : '' ) + word
                    encode_number callback, number, digits, next_string, left + word.length, digits.length, words_found + 1
                end
                right -= 1
            end
            
            if left > 0 && !last_was_digit then
                string_so_far += '-'
            end
            
            string_so_far += digits[left].to_s
            left += 1
            right = digits.length
            last_was_digit = true
            
        end
        
        if words_found > 0 then
            callback.call number, string_so_far
        end
    end

end
