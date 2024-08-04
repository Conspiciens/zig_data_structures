const std = @import("std");

pub const binary_search = struct {

    pub fn search(array: []u8, start: u8, end: u8, value: u8) bool {
        var low: u8 = start; 
        var high: u8 = end; 

        while (low <= high){
            const middle: u8 = low + (low + high) / 2;

            if (array[middle] == value)
                return true; 
            
            if (array[middle] < value){
                low = middle + 1; 
            } else {
                high = middle - 1;    
            } 
        }

        return false;
    }
        
};