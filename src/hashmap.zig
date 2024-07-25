const std = @import("std");

//custom errors for insertion and retrieval operations
const InsertError = error{
    MapFull, 
};

const GetError = error{
    KeyNotFound, 
};

//structure of an element in the hashmap
const Elem = struct {
    value: u32,         //value associated with the key
    key: [*:0]const u8, //key as a pointer to an array of bytes
    is_used: bool,      //flag to indicate if the slot is occupied
};

//structure of the hashmap
const HashMap = struct {
    capacity: usize,    //max num of elements for map
    pub var val: std.ArrayList(Elem) = undefined; //list to store elements
    pub var map_s: usize = 0; //counter for the number of elements in the map

    //hash function to compute the index for a given key
    pub fn hash(n: [*:0]const u8) usize {
        var result: usize = 0;
        //sum the bytes of the key with some modifications
        for (0..std.mem.len(n)) |i| {
            result += n[i] + 10 * 3;
        }
        return result;
    }

    //function to insert a key-value pair into the map
    pub fn insert(self: HashMap, key: [*:0]const u8, value: u32) !void {
        //check if the map is full
        if (map_s >= self.capacity) return InsertError.MapFull;

        //compute the initial index using the hash function
        var index: usize = hash(key) % self.capacity;

        //find an empty slot using linear probing
        while (val.items[index].is_used) {
            if (index >= self.capacity) index = 0;
            index += 1;
        }

        //append a new element to the val list
        try val.append(undefined);

        //set the new element at the computed index
        val.items[index] = Elem{
            .value = value,
            .key = key,
            .is_used = true,
        };

        map_s += 1;
    }

    //function to get value for a given key
    pub fn get(self: HashMap, key: [*:0]const u8) !u32 {
        for (0..self.capacity) |i| {
            if (val.items[i].key == key) return val.items[i].value;
        }
        return GetError.KeyNotFound;
    }

    //function for the map
    pub fn init() !HashMap {
        const allocator = std.heap.page_allocator;

        
        map_s = 0; //initialize the number of elements to 0

        //initialize the val list with the allocator
        val = std.ArrayList(Elem).init(allocator);

        //allocate memory for 50 elements and return a new map with that capacity
        val.items = try val.addManyAsArray(50);
        return HashMap{.capacity = 50};
    }
};

pub fn main() !void {
    var map: HashMap = try HashMap.init();
    
    
    try map.insert("key1", 100);
    try map.insert("key2", 200);
    try map.insert("key3", 300);
    
    const value1: u32 = try map.get("key1");
    const value2: u32 = try map.get("key2");
    const value3: u32 = try map.get("key3");

    std.debug.print("Value for 'key1': {d}\n", .{value1});
    std.debug.print("Value for 'key2': {d}\n", .{value2});
    std.debug.print("Value for 'key3': {d}\n", .{value3});
}


