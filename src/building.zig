const std = @import("std");
const item_type = @import("item.zig");
const math = @import("math.zig");
const world_type = @import("world.zig");

pub const conveyor = struct {
    position: math.ivec2,
    item: ?item_type.item,
    direction: math.Direction,

    pub fn init(direction: ?math.Direction) @This() {
        return conveyor{ 
            .position = math.ivec2{0, 0}, 
            .item = null, 
            .direction = direction orelse .up
        };
    }

    pub fn tick(this: *conveyor, from: world_type.world, to: world_type.world) void {
        if (this.item == null) return;

        const next_cell_position = this.position + math.get_vector_by_direction(this.direction, math.ivec2);

        var cell = from.get_cell_by_position(next_cell_position);

        if (cell == null) return; // If cell is empty
        if (cell.?.item != null) return; // If cell has something inside

        std.debug.print("{?} from {}\n", .{cell, this});

        cell.?.item = this.item;

        this.item = null;

        to.set_cell_by_position(next_cell_position, cell);
    }

    pub fn get_texture(this: @This()) *const [3:0]u8 {
        if (this.item != null) {
            return "[" ++ [_]u8{this.item.?.texture} ++ "]";
        } else {
            return "[ ]";
        }
    }
};
