const std = @import("std");
const stack = @import("stack.zig").Stack;
const binary_search = @import("binary_search.zig").binary_search;

pub fn main() !void {
    var stack_test: [100]u8 = undefined; 
    stack_test[0] = 10;

    var stack1 = stack.init(&stack_test, 100);
    stack1.add_item(1);
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
