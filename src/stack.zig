const std = @import("std");
const expect = std.testing.expect; 
const Allocator = std.mem.Allocator;

pub const Stack = struct {
    allocator: Allocator = undefined,
    memory: []u8 = undefined, 
    total_stack: u8 = undefined, 
    idx: u8 = 0,
    
    pub fn init(memory: []u8, total_stack: u8) Stack{
        var fba = std.heap.FixedBufferAllocator.init(memory);
        return Stack { 
            .allocator = fba.allocator(),
            .memory = memory, 
            .total_stack = total_stack
        }; 
    }

    pub fn is_empty(self: *Stack) bool {
        if (self.memory.len == 0)
            return true; 
        return false; 
    }

    pub fn is_full(self: *Stack) bool {
        if (self.memory.len == self.total_stack)
            return true; 
        return false;
    }

    pub fn add_item(self: *Stack, item: u8) void {
        if (self.is_full())
            return;
        self.memory[self.idx] = item;
        self.idx += 1;  
    }
};
