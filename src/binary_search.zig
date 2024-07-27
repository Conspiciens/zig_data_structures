const std = @import("std");

const binary_search = struct {
    array: []u8 = undefined, 
    start: u8, 
    end: u8,
    
    pub fn init(user_array: []u8, start: u8, end: u8) binary_search {
        return binary_search {
            .user_array = user_array, 
            .start = start, 
            .end = end,
        };
    }

    pub fn search(self: *binary_search, value: u8) bool {
        while (self.start < self.end) {
            const middle = (self.start + self.end) / 2;
            
            if (self.array[middle] <= self.end) {
                self.end = middle + 1;         
            } else {
                self.start = middle - 1;
            }
        }

        if (self.end > 0 and self.array[self.end - 1] == value)
            return true; 
        return false; 
    }
};