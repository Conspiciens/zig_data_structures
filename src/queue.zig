const std = @import("std");

const Node = struct {
    value: u32,
    next: ?*Node,
};

const Queue = struct {
    head: ?*Node, //point to first node
    tail: ?*Node, //last node

    //initialize an empty queue
    pub fn init() Queue {
        return Queue{ .head = null, .tail = null }; //queue starts with both head and tail set to null
    }

    //function to enqueue a new value at the end of the queue
    pub fn enqueue(self: *Queue, value: u32) !void {
        const allocator = std.heap.page_allocator;
        const node = try allocator.create(Node); //allocate memory for new node
        node.* = Node{ .value = value, .next = null };//initialize the new node with given value and no next node

        if (self.tail) |tail_node| { //if queue already has a tail, point to new node
            tail_node.next = node;
        } else {
            self.head = node;//if queue was empty, set the new node as the head
        }
        self.tail = node;//new node is tail
    }

    //function to dequeue a value from the front of the queue
    pub fn dequeue(self: *Queue) !?u32 {
        //if queue is not empty, get value from head node
        if (self.head) |head_node| {
            const value = head_node.value;
            self.head = head_node.next;
            if (self.head == null) {//if queue is empty after dequeue, set tail to null
                self.tail = null;
            }
            std.heap.page_allocator.destroy(head_node); //free memory of the removed value
            return value; //print it
        }
        return null; //if queue is empty, return null
    }

    //check if queue is empty
    pub fn is_empty(self: *Queue) bool {
        return self.head == null;
    }

    //function to traverse the queue and print each node's value
    pub fn traverse(self: *Queue) void {
        var current = self.head;
        while (current) |node| {
            std.debug.print("{d} -> ", .{node.value});
            current = node.next;
        }
        std.debug.print("null\n", .{});
    }
};

pub fn main() !void {
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

