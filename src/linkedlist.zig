const std = @import("std");

const Node = struct {
    value: u32,
    next: ?*Node,
};

pub const LinkedList = struct {
    head: ?*Node, //pointer

    //initialize empty list
    pub fn init() LinkedList {
        return LinkedList{ .head = null };
    }

    //function to insert a new value at the beginning of the list
    pub fn insert(self: *LinkedList, value: u32) !void {
        const allocator = std.heap.page_allocator;//for memory allocation
        const node = try allocator.create(Node);//allocate memory for new node
        node.* = Node{ .value = value, .next = self.head };//set node val to next pointer
        self.head = node;//update head to point to new node
    }

    //function to delete node w specified val from list
    pub fn delete(self: *LinkedList, value: u32) bool {
        var current = self.head;
        var prev: ?*Node = null;

        //traverse list to find node
        while (current) |node| {
            if (node.value == value) {
                if (prev) |p| { //if node is found, update pointers to remove it from the list
                    p.next = node.next;
                } else {
                    self.head = node.next;
                }
                std.heap.page_allocator.destroy(node);//deallocate
                return true;
            }
            prev = current;
            current = node.next;
        }
        return false;
    }

    //function to traverse the list and print each node's value
    pub fn traverse(self: *LinkedList) void {
        var current = self.head;
        while (current) |node| {
            std.debug.print("{d} -> ", .{node.value});
            current = node.next;
        }
        std.debug.print("null\n", .{});
    }
};

pub fn main() !void {
    var list = LinkedList.init();

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

    //print new list
    std.debug.print("List after deletion: ", .{});
    list.traverse();
}

