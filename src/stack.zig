const std = @import("std");
const expect = std.testing.expect; 

pub const Stack = struct {
    var memory: []u8 = undefined; 
    var total_stack: u8 = undefined;
    var idx: u8 = undefined;
    
    pub fn stack_init(int_amt: u8) void {
        const stack: [int_amt]u8 = undefined; 
        total_stack = int_amt;

        const stack_allocated = std.heap.HeapAllocator.init(&stack);
        var stack_allocator = std.heap.HeapAllocator.init(&stack_allocated);

        const allocator = stack_allocator.allocator(); 
        memory = try allocator.alloc(u8, int_amt);
    }

    pub fn is_empty() bool {
        if (memory.len == 0)
            return true; 
        return false; 
    }

    pub fn is_full() bool {
        if (memory.len == total_stack)
            return true; 
        return false;
    }

    pub fn add_item(item: u8) void{
        if (is_full())
            return;
        memory[idx] = item;
        idx += 1;  
    }
};
