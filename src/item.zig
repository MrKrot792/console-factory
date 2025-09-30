const std = @import("std");

// So three tiers for now.
pub const items = enum {
    copper,
    iron,
    titan,
};

pub const item = struct {
    texture: u8,
    name: []const u8,
};

pub const item_map: std.EnumArray(items, item) = .init(.{
    items.copper,
    item{ 'a', "copper" },
    null,
});
