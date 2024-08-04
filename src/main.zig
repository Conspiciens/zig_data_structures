const std = @import("std");
const stack = @import("stack.zig").Stack;
const binary_search = @import("binary_search.zig").binary_search;
const hashmap = @import("hashmap.zig").HashMap;
const quick_sort = @import("quicksort.zig").merge_sort;
const linked_list = @import("linkedlist.zig").LinkedList;
const Queue = @import("queue.zig").Queue;

pub fn main() !void {
    var stack_test: [100]u8 = undefined; 
    stack_test[0] = 10;

    // Test stack 
    var stack1 = stack.init(&stack_test, 100);
    stack1.add_item(1);
    stack1.add_item(2); 
    stack1.add_item(3);


    // Test HashMap
    var map: hashmap = try hashmap.init();
    
    
    try map.insert("key1", 100);
    try map.insert("key2", 200);
    try map.insert("key3", 300);
    
    const value1: u32 = try map.get("key1");
    const value2: u32 = try map.get("key2");
    const value3: u32 = try map.get("key3");

    std.debug.print("Value for 'key1': {d}\n", .{value1});
    std.debug.print("Value for 'key2': {d}\n", .{value2});
    std.debug.print("Value for 'key3': {d}\n", .{value3});


    // Test sorting and binary search 
    var array_test: [50]u8 = undefined; 

    array_test[0] = 5; 
    array_test[1] = 30; 
    array_test[30] = 2; 

    const sort = quick_sort;
    try sort.merge_divide(&array_test, 0, array_test.len - 1);
    std.debug.print("{}\n", .{array_test[0]});

    const binary_search_value = binary_search;
    const isValue: bool = binary_search_value.search(&array_test, 0, array_test.len - 1, 30);

    std.debug.print("{}\n", .{isValue});

    // Test Linked List 
    var list = linked_list.init();

    try list.insert(10);
    try list.insert(20);
    try list.insert(30);

    std.debug.print("List after insertion: ", .{});
    list.traverse();

    if (list.delete(20)) {
        std.debug.print("Deleted 20 from the list\n", .{});
    } else {
        std.debug.print("Value 20 not found in the list\n", .{});
    }

    std.debug.print("List after deletion: ", .{});
    list.traverse();

    // Test Queue 
    var queue = Queue.init();

    try queue.enqueue(15);
    try queue.enqueue(30);
    try queue.enqueue(45);

    std.debug.print("Queue after enqueuing: ", .{});
    queue.traverse();

    const value = try queue.dequeue();
    if (value) |v| {
        std.debug.print("Dequeued value: {d}\n", .{v});
    } else {
        std.debug.print("Queue is empty\n", .{});
    }

    std.debug.print("Queue after dequeuing: ", .{});
    queue.traverse();

}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
