const std = @import("std");
const item_type = @import("item.zig");
const math = @import("math.zig");
const world_type = @import("world.zig");

pub const Conveyor = struct {
    position: math.ivec2,
    item: ?item_type.Item,
    direction: math.Direction,

    pub fn init(direction: ?math.Direction) @This() {
        return Conveyor{ 
            .position = math.ivec2{0, 0}, 
            .item = null, 
            .direction = direction orelse .up
        };
    }

    pub fn tick(this: *Conveyor, from: world_type.World, to: world_type.World) void {
        if (this.item == null) return;

        const next_cell_position = this.position + math.get_vector_by_direction(this.direction, math.ivec2);

        var cell = from.getCellByPosition(next_cell_position);

        if (cell == null) return; // If cell is empty
        if (cell.?.item != null) return; // If cell has something inside

        std.debug.print("{?} from {}\n", .{cell, this});

        cell.?.item = this.item;
        this.item = null;

        to.setCellByPosition(next_cell_position, cell);
    }

    pub fn getTexture(this: @This()) *const [3:0]u8 {
        if (this.item != null) {
            return "[" ++ [_]u8{this.item.?.texture} ++ "]";
        } else {
            return "[ ]";
        }
    }
};
