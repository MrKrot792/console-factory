const std = @import("std");
const item = @import("item.zig");
const math = @import("math.zig");

const building = struct {
    position: math.ivec2,
};

pub const conveyor = struct {
    base: building,
    item: ?item.item,

    pub fn init() @This() {
        return conveyor{.base = .{ .position = math.ivec2{0, 0}}, .item = null};
    }

    pub fn tick(this: @This()) void {
        _ = this;
        if (item != null) {
            std.debug.print("I have an item.", .{});
        } else {
            std.debug.print("I do not have an item.", .{});
        }
    }

    pub fn get_texture(this: @This()) *const [3:0]u8 {
        if (this.item != null) {
            return "[x]";
        } else {
            return "[ ]";
        }
    }
};
