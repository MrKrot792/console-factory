const std = @import("std");
pub const building = @import("building.zig");
const math = @import("math.zig");

pub const cell = ?building.conveyor; // TODO: Implement an interface

pub const world_size = 1024;

pub const world = struct {
    data: []cell = undefined,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) !world {
        var result: @This() = .{ .allocator = allocator };
        result.data = try allocator.alloc(cell, world_size*world_size); // 64 Mb is a big number!

        for(result.data) |*value| {
            value.* = null;
        }

        return result;
    }

    pub fn deinit(this: @This()) void {
        this.allocator.free(this.data);
    }

    pub fn get_cell_by_position(this: @This(), position: math.ivec2) cell {
        if (position[0] < 0 or position[1] < 0) return null;

        return this.data[@as(usize, @intCast(position[0])) + @as(usize, @intCast(position[1])) * world_size]; // Scary!
    }

    pub fn set_cell_by_position(this: world, position: @Vector(2,i32), c: cell) void {
        var ce = c;
        ce.?.position = position;
        this.data[@as(usize, @intCast(position[0])) + @as(usize, @intCast(position[1])) * world_size] = ce;
    }
};
