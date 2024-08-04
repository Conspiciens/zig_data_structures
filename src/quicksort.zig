const std = @import("std");


pub const merge_sort = struct {

    pub fn merge_divide(array: []u8, start: u8, end: u8) !void {
        if (start >= end)
            return; 
        
        const mid = start + (end - start) / 2; 
        try merge_divide(array, start, mid); 
        try merge_divide(array, mid + 1, end); 
        try merge(array, start, mid, end); 

        return;
    }

    fn merge(array: []u8, left: u8, mid: u8, right:u8) !void {
        const sub_array_one: u8 = mid - left + 1; 
        const sub_array_two: u8 = right - mid; 

        var gpa = std.heap.GeneralPurposeAllocator(.{}) {};
        const allocator = gpa.allocator();

        defer {
            const deinit_status = gpa.deinit(); 
            if (deinit_status == .leak) std.testing.expect(false) catch @panic("TEST FAIL");
        }


        var temp_array_one = try allocator.alloc(u8, sub_array_one); 
        var temp_array_two = try allocator.alloc(u8, sub_array_two);

        defer allocator.free(temp_array_one);
        defer allocator.free(temp_array_two);


        for (0..sub_array_one) |i|{
            temp_array_one[i] = array[left + i]; 
        }

        for (0..sub_array_two) |i| {
            temp_array_two[i] = array[mid + 1 + i];
        }

        var idx_sub_array_one: u8 = 0;
        var idx_sub_array_two: u8 = 0; 
        var idx_merged_array: u8 = left;  

        while (idx_sub_array_one < sub_array_one and idx_sub_array_two < sub_array_two) {
            if (temp_array_one[idx_sub_array_one] <= temp_array_two[idx_sub_array_two]){
                array[idx_merged_array] = temp_array_one[idx_sub_array_one];
                idx_sub_array_one += 1; 
            } else {
                array[idx_merged_array] = temp_array_two[idx_sub_array_two];
                idx_sub_array_two += 1;
            }
            idx_merged_array += 1;
        }

        while (idx_sub_array_one < sub_array_one) : ({
            idx_sub_array_one += 1;  
            idx_merged_array += 1; 
        }) {
            array[idx_merged_array] = temp_array_one[idx_sub_array_one]; 
        }

        while (idx_sub_array_two < sub_array_two) : ({
            idx_sub_array_two += 1; 
            idx_merged_array += 1;
        }) {
            array[idx_merged_array] = temp_array_two[idx_sub_array_two];
        }
    }

};