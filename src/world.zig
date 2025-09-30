const std = @import("std");
pub const building = @import("building.zig");
const math = @import("math.zig");

pub const cell = ?building.conveyor; // TODO: Implement an interface

pub const world_size = 1024;

pub const world = struct {
    data: []cell = undefined,
    allocator: std.mem.Allocator = undefined,

    pub fn init(allocator: std.mem.Allocator) !world {
        var result: @This() = world{};
        result.allocator = allocator;
        result.data = allocator.alloc(cell, world_size*world_size); // 64 Mb is a big number!

        for(result.data) |*value| {
            value.* = null;
        }

        return result;
    }

    pub fn deinit(this: @This()) void {
        this.allocator.free(this.data);
    }

    pub fn get_cell_by_position(this: @This(), position: math.vec2) cell {
        return this.data[position[0] + position[1] * world_size]; // Scary!
    }
};
